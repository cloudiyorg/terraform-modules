variable "region" {
  type        = string
  description = "Region"
}

variable "env" {
  type        = string
  description = "Environment namespace."
}

variable "account-id" {
  type        = string
  description = "Account ID"
}

variable "lambda_function_name" {
  type        = string
}

variable "lambda_function_handler" {
  type        = string
}

variable "lambda_function_runtime" {
  type        = string
}

variable "lambda_function_filename" {
  type        = string
}