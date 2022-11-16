variable "region" {
  type        = string
  description = "Region"
}

variable "env" {
  type        = string
  description = "Environment namespace."
}

variable "loadbalancer_enable_deletion_protection" {
  type        = bool
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "acm_certificate_arn" {
  type = string
}

variable "loadbalancer_name" {
  type = string
}

variable "loadbalancer_internal" {
  type = bool
}

variable "loadbalancer_type" {
  type = string
}

variable "loadbalancer_https_listener_protocol" {
  type = string
}

variable "loadbalancer_https_listener_port" {
  type = number
}

variable "loadbalancer_https_listener_default_action_type" {
  type = string
}

variable "loadbalancer_http_listener_protocol" {
  type = string
}

variable "loadbalancer_http_listener_port" {
  type = number
}

variable "loadbalancer_http_listener_default_action_type" {
  type = string
}

variable "loadbalancer_http_listener_default_action_redirect_port" {
  type = string
}

variable "loadbalancer_http_listener_default_action_redirect_protocol" {
  type = string
}

variable "loadbalancer_http_listener_default_action_redirect_status_code" {
  type = string
}

variable "loadbalancer_default_target_group_name" {
  type = string
}

variable "loadbalancer_default_target_group_port" {
  type = number
}

variable "loadbalancer_default_target_group_protocol" {
  type = string
}

variable "loadbalancer_default_target_group_target_type" {
  type = string
}

variable "loadbalancer_default_target_group_health_check_path" {
  type = string
}

variable "loadbalancer_default_target_group_health_check_port" {
  type = string
}

variable "loadbalancer_default_target_group_health_check_healthy_threshold" {
  type = number
}

variable "loadbalancer_default_target_group_health_check_unhealthy_threshold" {
  type = number
}

variable "loadbalancer_default_target_group_health_check_timeout" {
  type = number
}

variable "loadbalancer_default_target_group_health_check_protocol" {
  type = string
}

variable "loadbalancer_default_target_group_health_check_interval" {
  type = number
}

variable "loadbalancer_default_target_group_health_check_matcher" {
  type = string
}

variable "loadbalancer_listener_rule_action_type" {
  type = string
}

variable "loadbalancer_listener_rule_condition_host_header_values" {
  type = list(string)
}