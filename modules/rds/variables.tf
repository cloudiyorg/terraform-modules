variable "region" {
  type        = string
  description = "Region"
}

variable "env" {
  type        = string
  description = "Environment namespace."
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "db_storage_type" {
  type = string
}

variable "db_allocated_storage" {
  type = number
}

variable "db_engine" {
  type = string
}

variable "db_engine_version" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_instance_type" {
  type = string
}

variable "db_publicly_accessible" {
  type = bool
}

variable "db_multi_az" {
  type = bool
}

variable "db_skip_final_snapshot" {
  type = bool
}

variable "db_apply_immediately" {
  type = bool
}

variable "db_allow_major_version_upgrade" {
  type = bool
}

variable "db_performance_insights_enabled" {
  type = bool
}

variable "db_performance_insights_retention_period" {
  type = number
}

variable "db_final_snapshot_identifier" {
  type = string
}

variable "db_snapshot_identifier" {
  type = string
}

variable "db_backup_retention_period" {
  type = number
}

variable "db_maintenance_window" {
  type = string
}

variable "db_backup_window" {
  type = string
}

variable "db_deletion_protection" {
  type = bool
}

variable "db_enabled_cloudwatch_logs_exports" {
  type = list(string)
}



/*


variable "deletion_protection" {
  type    = map(string)
  default = {
    acceptance = false,
    production = true
  }
}

variable "multi_az" {
  type    = map(string)
  default = {
    acceptance = false,
    production = true
  }
}

variable "db_snapshot_identifier" {
  type    = map(string)
  default = {
    acceptance: ""
    production: ""
  }
}

variable "read_replica_db_snapshot_identifier" {
  type    = map(string)
  default = {
    acceptance: "misinapp-postgresql-db-final-snapshot-acceptance"
    production: ""
  }
}

variable "rds_backup_retention_period" {
  type    = map(number)
  default = {
    acceptance  = 1
    production  = 30
  }
}

*/