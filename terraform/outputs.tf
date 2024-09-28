# Output the public IP address of the EC2 instance
output "ec2_info" {
  value = {
    public_ip = aws_instance.web.public_ip
    user_name = regex_replace(data.aws_caller_identity.current.arn, "^arn:aws:iam::[0-9]+:user/(.*)$", "$1")
  }
}