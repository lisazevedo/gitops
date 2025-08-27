terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.is_local ? "test" : null
  secret_key = var.is_local ? "test" : null

  skip_credentials_validation = var.is_local
  skip_metadata_api_check     = var.is_local
  skip_requesting_account_id  = var.is_local
  s3_use_path_style         = var.is_local

  dynamic "endpoints" {
    for_each = var.is_local ? [1] : []
    content {
      apigateway       = "http://localhost:4566"
      cloudformation   = "http://localhost:4566"
      cloudwatch       = "http://localhost:4566"
      dynamodb         = "http://localhost:4566"
      ec2              = "http://localhost:4566"
      iam              = "http://localhost:4566"
      kinesis          = "http://localhost:4566"
      lambda           = "http://localhost:4566"
      route53          = "http://localhost:4566"
      s3               = "http://localhost:4566"
      secretsmanager   = "http://localhost:4566"
      ses              = "http://localhost:4566"
      sns              = "http://localhost:4566"
      sqs              = "http://localhost:4566"
      ssm              = "http://localhost:4566"
      sts              = "http://localhost:4566"
    }
  }
}