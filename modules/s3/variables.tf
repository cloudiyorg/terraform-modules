variable "region" {
  type        = string
  description = "Region"
}

variable "env" {
  type        = string
  description = "Environment namespace."
}

variable "s3_bucket_name" {
  type        = string
}

variable "s3_versioning" {
  type        = string
}

variable "s3_lifecycle_rule_id" {
  type        = string
}

variable "s3_lifecycle_rule_status" {
  type        = string
}

variable "s3_lifecycle_rule_expiration" {
  type        = number
}

variable "s3_block_public_acls" {
  type        = bool
}

variable "s3_block_public_policy" {
  type        = bool
}

variable "s3_ignore_public_acls" {
  type        = bool
}

variable "s3_restrict_public_buckets" {
  type        = bool
}