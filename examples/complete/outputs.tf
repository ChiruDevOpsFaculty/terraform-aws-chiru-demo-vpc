output "vpc" {
  value = module.myvpc.vpc_id
}

output "public_subnet" {
  value = module.myvpc.public_subnets
}

output "private_subnet" {
  value = module.myvpc.private_subnets
}