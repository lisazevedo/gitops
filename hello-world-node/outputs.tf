output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private.id
}

output "security_group_id" {
  description = "The ID of the web server security group"
  value       = aws_security_group.web_server.id
}

output "ec2_instance_id" {
  description = "The ID of the EC2 web server instance"
  value       = aws_instance.web_server.id
}

output "ec2_public_ip" {
  description = "The public IP of the EC2 instance (use this for SSH/HTTP access)"
  value       = aws_instance.web_server.public_ip
}

output "ec2_public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = aws_instance.web_server.public_dns
}