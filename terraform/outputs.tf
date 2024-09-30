# Output the public IP address of the EC2 instance
output "ec2_info" {
  value = {
    public_ip = aws_instance.web-server.public_ip
  }
}
