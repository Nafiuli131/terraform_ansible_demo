variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "vpc_cidr" { type = string }
variable "public_subnet_cidr" { type = string }
variable "private_subnet_cidr" { type = string }
variable "instance_type" { type = string }
variable "instance_name" { type = string }
variable "ssh_public_key_path" {
  type    = string
  default = "keys/id_rsa.pub"
  description = "Path to local SSH public key (relative to project root). Place your id_rsa.pub at this path."
}
