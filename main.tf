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

  provisioner "remote-exec" {
    inline = [
      "echo ${self.private_ip} >> /etc/hosts"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.ssh_private_key)
      host        = self.public_ip
    }
  }
}
