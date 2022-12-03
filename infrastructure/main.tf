locals {
  terraform_variables = jsondecode(file("${path.module}/variables.json"))
}

module "vpc" {
  source              = "git@github.com:clouddiy/terraform-modules.git//modules/vpc"
  vpc_cidr_block      = local.terraform_variables.variable.vpc_cidr_blocks.default
  env                 = local.terraform_variables.locals.env
  region              = local.terraform_variables.locals.region
  private_cidr_blocks = local.terraform_variables.variable.public_cidr_blocks.default[*]
  public_cidr_blocks  = local.terraform_variables.variable.private_cidr_blocks.default[*]
}

module "rds" {
  source                 = "../modules/rds"
  env                    = local.terraform_variables.locals.env
  region                 = local.terraform_variables.locals.region
  private_subnet_ids     = module.vpc.private_subnet.*.id
  public_subnet_ids      = module.vpc.public_subnet.*.id
  username               = local.terraform_variables.variable.db_username.default
  password               = local.terraform_variables.variable.db_password.default
  db_storage_type        = local.terraform_variables.variable.db_storage_type.default
  db_allocated_storage   = local.terraform_variables.variable.db_allocated_storage.default
  db_engine              = local.terraform_variables.variable.db_engine.default
  db_engine_version      = local.terraform_variables.variable.db_engine_version.default
  db_name                = local.terraform_variables.variable.db_name.default
  db_instance_type       = local.terraform_variables.variable.db_instance_type.default
  db_publicly_accessible = local.terraform_variables.variable.db_publicly_accessible.default
  db_multi_az            = local.terraform_variables.variable.db_multi_az.default
  db_skip_final_snapshot = local.terraform_variables.variable.db_skip_final_snapshot.default
  db_apply_immediately   = local.terraform_variables.variable.db_apply_immediately.default
  db_snapshot_identifier = local.terraform_variables.variable.db_snapshot_identifier.default
  db_maintenance_window  = local.terraform_variables.variable.db_maintenance_window.default
  db_backup_window       = local.terraform_variables.variable.db_backup_window.default
  db_deletion_protection = local.terraform_variables.variable.db_deletion_protection.default
  db_backup_retention_period       = local.terraform_variables.variable.db_backup_retention_period.default
  db_allow_major_version_upgrade   = local.terraform_variables.variable.db_allow_major_version_upgrade.default
  db_performance_insights_enabled  = local.terraform_variables.variable.db_performance_insights_enabled.default
  db_final_snapshot_identifier     = local.terraform_variables.variable.db_final_snapshot_identifier.default
  db_enabled_cloudwatch_logs_exports        = local.terraform_variables.variable.db_enabled_cloudwatch_logs_exports.default
  db_performance_insights_retention_period  = local.terraform_variables.variable.db_performance_insights_retention_period.default
}

module "s3" {
  source                       = "../modules/s3"
  env                          = local.terraform_variables.locals.env
  region                       = local.terraform_variables.locals.region
  s3_bucket_name               = local.terraform_variables.variable.s3_bucket_name.default
  s3_versioning                = local.terraform_variables.variable.s3_versioning.default
  s3_lifecycle_rule_id         = local.terraform_variables.variable.s3_lifecycle_rule_id.default
  s3_lifecycle_rule_status     = local.terraform_variables.variable.s3_lifecycle_rule_status.default
  s3_lifecycle_rule_expiration = local.terraform_variables.variable.s3_lifecycle_rule_expiration.default
  s3_block_public_acls         = local.terraform_variables.variable.s3_block_public_acls.default
  s3_block_public_policy       = local.terraform_variables.variable.s3_block_public_policy.default
  s3_ignore_public_acls        = local.terraform_variables.variable.s3_ignore_public_acls.default
  s3_restrict_public_buckets   = local.terraform_variables.variable.s3_restrict_public_buckets.default
}

module "cloudfront" {
  source                          = "../modules/cloudfront"
  env                             = local.terraform_variables.locals.env
  region                          = local.terraform_variables.locals.region
  cloudfront_distribution_aliases = local.terraform_variables.variable.cloudfront_distribution_aliases.default
  cloudfront_distribution_enable  = local.terraform_variables.variable.cloudfront_distribution_enable.default
  cloudfront_distribution_cache_allowed_methods  = local.terraform_variables.variable.cloudfront_distribution_cache_allowed_methods.default
  cloudfront_distribution_cache_cached_methods   = local.terraform_variables.variable.cloudfront_distribution_cache_cached_methods.default
  cloudfront_distribution_cache_target_origin_id = local.terraform_variables.variable.cloudfront_distribution_cache_target_origin_id.default
  cloudfront_distribution_cache_viewer_protocol_policy = local.terraform_variables.variable.cloudfront_distribution_cache_viewer_protocol_policy.default
  cloudfront_distribution_cache_compress         = local.terraform_variables.variable.cloudfront_distribution_cache_compress.default
  cloudfront_distribution_default_root_object    = local.terraform_variables.variable.cloudfront_distribution_default_root_object.default
  cloudfront_distribution_origin_domain_name     = local.terraform_variables.variable.cloudfront_distribution_origin_domain_name.default
  cloudfront_distribution_geo_restriction_type   = local.terraform_variables.variable.cloudfront_distribution_geo_restriction_type.default
  cloudfront_distribution_viewer_certificate     = local.terraform_variables.variable.cloudfront_distribution_viewer_certificate.default
}

module "acm" {
  source              = "../modules/acm"
  env                 = local.terraform_variables.locals.env
  region              = local.terraform_variables.locals.region
  acm_domain_name     = local.terraform_variables.variable.acm_domain_name.default
}

module "loadbalancer" {
  source                   = "../modules/loadbalancer"
  env                      = local.terraform_variables.locals.env
  region              = local.terraform_variables.locals.region
  vpc_id                   = module.vpc.vpc_id
  public_subnet_ids        = module.vpc.public_subnet.*.id
  acm_certificate_arn      = module.acm.project_acm_certificate_arn
  loadbalancer_enable_deletion_protection      = local.terraform_variables.variable.loadbalancer_enable_deletion_protection.default
  loadbalancer_name      = local.terraform_variables.variable.loadbalancer_name.default
  loadbalancer_internal      = local.terraform_variables.variable.loadbalancer_internal.default
  loadbalancer_type      = local.terraform_variables.variable.loadbalancer_type.default
  loadbalancer_https_listener_protocol      = local.terraform_variables.variable.loadbalancer_https_listener_protocol.default
  loadbalancer_https_listener_port      = local.terraform_variables.variable.loadbalancer_https_listener_port.default
  loadbalancer_https_listener_default_action_type      = local.terraform_variables.variable.loadbalancer_https_listener_default_action_type.default
  loadbalancer_http_listener_protocol      = local.terraform_variables.variable.loadbalancer_http_listener_protocol.default
  loadbalancer_http_listener_port      = local.terraform_variables.variable.loadbalancer_http_listener_port.default
  loadbalancer_http_listener_default_action_type      = local.terraform_variables.variable.loadbalancer_http_listener_default_action_type.default
  loadbalancer_http_listener_default_action_redirect_port      = local.terraform_variables.variable.loadbalancer_http_listener_default_action_redirect_port.default
  loadbalancer_http_listener_default_action_redirect_protocol      = local.terraform_variables.variable.loadbalancer_http_listener_default_action_redirect_protocol.default
  loadbalancer_http_listener_default_action_redirect_status_code      = local.terraform_variables.variable.loadbalancer_http_listener_default_action_redirect_status_code.default
  loadbalancer_default_target_group_name      = local.terraform_variables.variable.loadbalancer_default_target_group_name.default
  loadbalancer_default_target_group_port      = local.terraform_variables.variable.loadbalancer_default_target_group_port.default
  loadbalancer_default_target_group_protocol      = local.terraform_variables.variable.loadbalancer_default_target_group_protocol.default
  loadbalancer_default_target_group_target_type      = local.terraform_variables.variable.loadbalancer_default_target_group_target_type.default
  loadbalancer_default_target_group_health_check_path      = local.terraform_variables.variable.loadbalancer_default_target_group_health_check_path.default
  loadbalancer_default_target_group_health_check_port      = local.terraform_variables.variable.loadbalancer_default_target_group_health_check_port.default
  loadbalancer_default_target_group_health_check_healthy_threshold      = local.terraform_variables.variable.loadbalancer_default_target_group_health_check_healthy_threshold.default
  loadbalancer_default_target_group_health_check_unhealthy_threshold      = local.terraform_variables.variable.loadbalancer_default_target_group_health_check_unhealthy_threshold.default
  loadbalancer_default_target_group_health_check_timeout      = local.terraform_variables.variable.loadbalancer_default_target_group_health_check_timeout.default
  loadbalancer_default_target_group_health_check_protocol      = local.terraform_variables.variable.loadbalancer_default_target_group_health_check_protocol.default
  loadbalancer_default_target_group_health_check_interval      = local.terraform_variables.variable.loadbalancer_default_target_group_health_check_interval.default
  loadbalancer_default_target_group_health_check_matcher      = local.terraform_variables.variable.loadbalancer_default_target_group_health_check_matcher.default
  loadbalancer_listener_rule_action_type      = local.terraform_variables.variable.loadbalancer_listener_rule_action_type.default
  loadbalancer_listener_rule_condition_host_header_values      = local.terraform_variables.variable.loadbalancer_listener_rule_condition_host_header_values.default
}

module "ecs" {
  source              = "../modules/ecs"
  env                 = local.terraform_variables.locals.env
  region              = local.terraform_variables.locals.region
}