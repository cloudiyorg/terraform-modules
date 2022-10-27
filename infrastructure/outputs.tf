output "private_subnet" {
  value = module.vpc.private_subnet
}

output "vpc_id" {
  description = "The ID of the VPC"
  value = module.vpc.vpc_id
}

output "public_subnet" {
  value = module.vpc.public_subnet
}