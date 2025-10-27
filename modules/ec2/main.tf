# create key pair from local public key
resource "local_file" "pubkey" {
  filename = "${path.module}/temp_pubkey.pub"
  content  = file(var.ssh_public_key_path)
}

resource "aws_key_pair" "deployer" {
  key_name   = "demo-key-\${random_id.key_suffix.hex}")
  public_key = file(var.ssh_public_key_path)
}

resource "random_id" "key_suffix" {
  byte_length = 4
}

data "aws_ami" "amazonlinux2" {
  most_recent = true
  owners      = ["137112412989"] # Amazon
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_security_group" "web_sg" {
  name        = "demo-web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "demo-web-sg" }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazonlinux2.id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name = aws_key_pair.deployer.key_name

  tags = {
    Name = var.instance_name
  }
}

resource "aws_eip" "web_eip" {
  instance = aws_instance.web.id
  vpc = true
}
