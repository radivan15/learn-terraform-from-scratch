variable "region" {
  type        = string
  description = "AWS region tempat VPC dibuat"
  default     = "ap-southeast-1"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block untuk VPC"
}

variable "name" {
  type        = string
  description = "Nama VPC, dipakai di tag Name (contoh: learn-terraform-dev)"
}