terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "depi-bucket"
    key    = "terraform.tfstate"
    region = var.aws_region
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

resource "aws_key_pair" "github_actions" {
  key_name   = "github-actions-key"
  public_key = file(var.ssh_public_key)
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web-server" {
  depends_on                  = [aws_security_group.allow_ssh]
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.github_actions.key_name
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  associate_public_ip_address = true

  tags = {
    Name = "web-server"
  }

  # User data to install OpenSSH server
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y openssh-server
              systemctl enable sshd
              systemctl start sshd
              EOF

}
