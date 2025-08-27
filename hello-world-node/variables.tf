variable "is_local" {
    description = "Set to true to use LocalStack, false to use AWS"
    type        = bool
    default     = false
}

variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
    description = ""
    type        = string
    default     = "10.0.0.0/16"
}

variable "private_subnet_cidr_block" {
    description = ""
    type        = string
    default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_block" {
    description = ""
    type        = string
    default     = "10.0.2.0/24"
}

variable "ec2_instance_type" {
  description = "The instance type for the EC2 server."
  type        = string
  default     = "t3.micro"
}

variable "ec2_ami" {
  description = "The AMI ID for the EC2 instance."
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "ec2_key_name" {
  description = "The name of the EC2 key pair for SSH access."
  type        = string
}