resource "aws_instance" "web_server" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.web_server.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  tags                   = { Name = "web-server-instance" }
  user_data              = file("initial_config.sh")
}

