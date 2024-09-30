# Output the public IP address of the EC2 instance
output "public_ip" {
  value = aws_instance.web-server.public_ip
}
