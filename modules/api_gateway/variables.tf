variable "region" {
  type        = string
  description = "Region"
}

variable "env" {
  type        = string
  description = "Environment namespace."
}

variable "api_gateway_api_key_name" {
  type = string
}

variable "api_gateway_rest_api_name" {
  type = string
}

variable "api_gateway_rest_api_disable_execute_api_endpoint" {
  type = bool
}

variable "api_gateway_rest_api_endpoint_configuration_types" {
  type = list(string)
}

variable "api_gateway_api_gateway_usage_plan_name" {
  type = string
}

variable "api_gateway_usage_plan_key_key_type" {
  type = string
}

variable "api_gateway_stage_stage_name" {
  type = string
}

variable "api_gateway_stage_cache_cluster_enabled" {
  type = bool
}

variable "api_gateway_stage_cache_cluster_size" {
  type = number
}

variable "api_gateway_resource_path_part" {
  type = string
}

variable "api_gateway_integration_uri" {
  type = string
}