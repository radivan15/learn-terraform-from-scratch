terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0" # module pakai batas minimum saja, root yang mengunci versi
    }
  }
}

# Tidak ada block provider "aws" di sini, provider dikonfigurasi oleh root
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.name # nama datang dari pemanggil (environment), bukan hardcode
  }

}
