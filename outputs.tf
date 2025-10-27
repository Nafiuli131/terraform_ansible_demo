output "instance_public_ip" {
  value = module.ec2.instance_public_ip
}

output "instance_private_ip" {
  value = module.ec2.instance_private_ip
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}
