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
