variable "region" {
  type        = string
  description = "AWS region tempat VPC dibuat"
  default     = "ap-southeast-1"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block untuk VPC"
  default     = "10.0.0.0/16"
}
