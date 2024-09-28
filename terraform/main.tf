# Configure AWS credentials
provider "aws" {
  region = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

# Create a subnet
resource "aws_subnet" "public" {
  vpc_id      = aws_vpc.main.id
  cidr_block  = var.subnet_cidr_block
  availability_zone = var.availability_zone
}

# Create an internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Create a route table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
}

# Create a route for internet traffic
resource "aws_route" "internet_gateway" {
  route_table_id     = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id         = aws_internet_gateway.main.id
}

# Associate the subnet with the route table
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.main.id
}

resource "aws_key_pair" "my_key" {
  key_name     = var.key_name
  public_key    = file(var.key_path)
}


# Create an EC2 instance
resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  key_name     = var.key_name

  tags = {
    Name = "My EC2 Instance"
  }
}