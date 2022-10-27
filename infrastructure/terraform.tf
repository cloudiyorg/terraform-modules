provider "aws" {
  region              = local.terraform_variables.locals.region
  allowed_account_ids = local.terraform_variables.locals.account-id[*]
}

terraform {
  required_version = "1.1.9"
  required_providers {
    aws = {
      version      = "3.46.0"
    }
  }
}
