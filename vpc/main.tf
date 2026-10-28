terraform {
  required_version = "~> 1.16"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"

  # Tag ini otomatis ditempel ke semua resource yang mendukung tag
  default_tags {
    tags = {
      Project   = "learn-terraform"
      ManagedBy = "terraform"
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  # Dua setting DNS ini dibutuhkan kalau nanti pakai VPC Endpoint
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "learn-terraform-vpc"
  }
}
