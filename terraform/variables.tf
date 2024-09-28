variable "aws_access_key_id" {
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  type        = string
  sensitive   = true
}

variable "region" {
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  type        = string
  default     = "10.0.0.0/24"
}

variable "availability_zone" {
  type        = string
  default     = "us-east-1a"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  type        = string
  default     = "ami-005fc0f236362e99f"
}

variable "key_name" {
  type        = string
  default     = "your_key_pair_name"
}

variable "key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}