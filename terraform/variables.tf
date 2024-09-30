variable "region" {
  type    = string
  default = "us-east-1"
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

variable "key_name_value" {
  type    = string
  default = "your_key_pair_name"
}

