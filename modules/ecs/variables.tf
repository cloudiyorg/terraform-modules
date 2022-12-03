variable "region" {
  type        = string
  description = "Region"
}

variable "env" {
  type        = string
  description = "Environment namespace."
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_container_insights_settings" {
  type = string
}