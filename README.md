# Terraform + Ansible Demo: VPC, public/private subnets, EC2 + Nginx

**What this contains**
- Terraform (modular) to create:
  - VPC
  - Public subnet + Internet Gateway + public route table
  - Private subnet + NAT Gateway
  - Security Group allowing SSH (22) and HTTP (80)
  - EC2 instance placed in the public subnet (so Ansible can connect)
- Ansible playbook to install Nginx on the EC2 instance
- A small Python helper that generates an Ansible inventory from `terraform output -json`.

**Important: before running**
1. Install Terraform (>= 1.0) and AWS CLI configured with credentials for the target AWS account/region.
   - Export AWS creds as env variables or configure `~/.aws/credentials`.
2. Place your SSH public key here: `keys/id_rsa.pub` (replace the placeholder). Terraform will use this public key to create an EC2 Key Pair.
   - Do NOT store private keys in this repo. Use your own private key locally to SSH/Ansible to the instance.
3. Adjust variables in `terraform.tfvars` if desired (region, instance type, etc.).

**How to run**
```bash
# from project root
cd terraform-ansible-demo
terraform init
terraform apply -var="aws_region=us-east-1" -auto-approve

# after apply finishes, generate inventory
terraform output -json > tf-output.json
python3 generate_inventory.py tf-output.json inventory.ini

# run ansible (ensure you have lib 'paramiko' or ssh access set up)
ansible-playbook -i inventory.ini ansible/install_nginx.yml --private-key /path/to/your/id_rsa
```

**Notes**
- The included `keys/id_rsa.pub` is a placeholder. Replace it with your real public key before running.
- The EC2 uses a community AMI lookup for Amazon Linux 2 in the configured region.
- The project is intentionally minimal and intended for learning/demo purposes.
# terraform_ansible_demo
