variable "region" {
  type        = string
  description = "Region"
}

variable "env" {
  type        = string
  description = "Environment namespace."
}

variable "vpc_cidr_block" {
  type = string
}

variable "public_cidr_blocks" {
  type    = list(string)
}
variable "private_cidr_blocks" {
  type    = list(string)
}