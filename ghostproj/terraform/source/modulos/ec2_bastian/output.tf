 output "aws_instance_private_ip_bastian" {
  value = "$(aws_instance.criar_ec2.private_ip)"
}