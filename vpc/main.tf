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
  region = var.region

  # Tag ini otomatis ditempel ke semua resource yang mendukung tag
  default_tags {
    tags = {
      Project   = "learn-terraform"
      ManagedBy = "terraform"
    }
  }
}

module "vpc" {
  source = "../modules/vpc" # path lokal, relatif terhadap folder vpc/

  vpc_cidr = var.vpc_cidr # oper variabel root ke input module
}

# Memberi tahu Terraform: resource ini cuma pindah alamat, bukan resource baru
moved {
  from = aws_vpc.main            # alamat lama di state
  to   = module.vpc.aws_vpc.main # alamat baru
}
