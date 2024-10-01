variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_access_key_id" {
  type      = string
  sensitive = true
}

variable "aws_secret_access_key" {
  type      = string
  sensitive = true
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type    = string
  default = "ami-005fc0f236362e99f"
}

variable "ssh_public_key" {
  type    = string
  default = "~/.ssh/github-actions-key.pub"
}

variable "ssh_private_key" {
  type    = string
  default = "~/.ssh/github-actions-key"
}

