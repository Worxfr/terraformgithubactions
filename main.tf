

terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
        }
    }
    backend "s3" {
    encrypt        = true
  }
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}