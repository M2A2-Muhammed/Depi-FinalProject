# Output the public IP address of the EC2 instance
output "instance_ip" {
  value = aws_instance.web-server.public_ip
}

output "default_user" {
  value = data.aws_ami.selected.virtualization_type == "hvm" ? "ec2-user" : "ubuntu" # Adjust based on AMI
}
