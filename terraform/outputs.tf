# Output the public IP address of the EC2 instance
output "public_ip" {
  value = aws_instance.web-server.public_ip
}

output "ssh_security_group_id" {
  value = aws_security_group.allow_ssh.id
}
