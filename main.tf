terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-key-pair"
  public_key = var.key_name_value

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
  depends_on      = [aws_security_group.allow_ssh]
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "my-web"
  }
}
