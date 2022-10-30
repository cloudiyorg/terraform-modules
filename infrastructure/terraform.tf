provider "aws" {
  region              = local.terraform_variables.locals.region
  allowed_account_ids = local.terraform_variables.locals.account-id[*]
}

terraform {
  required_version = "1.3.3"
  required_providers {
    aws = {
      version      = "4.36.1"
    }
  }
}
