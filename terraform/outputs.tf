# Output the public IP address of the EC2 instance
output "ec2_info" {
  value = {
    user = aws_instance.web.username
    public_ip = aws_instance.web.public_ip
  }
}