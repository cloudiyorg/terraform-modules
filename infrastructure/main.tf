locals {
  terraform_variables = jsondecode(file("${path.module}/variables.json"))
}

module "vpc" {
  source              = "../modules/vpc"
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