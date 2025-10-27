# root module - calls vpc and ec2 modules
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidr  = var.private_subnet_cidr
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id               = module.vpc.vpc_id
  public_subnet_id     = module.vpc.public_subnet_id
  ssh_public_key_path  = var.ssh_public_key_path
  instance_type        = var.instance_type
  instance_name        = var.instance_name
}
