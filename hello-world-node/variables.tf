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
  default     = "ami-0bbdd8c17ed981ef9"
}

variable "github_org" {
  description = "value"
  type        = string
}

variable "github_repo" {
  description = "value"
  type        = string
}