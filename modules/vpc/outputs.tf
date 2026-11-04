output "vpc_id" {
  description = "ID VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block VPC"
  value       = aws_vpc.main.cidr_block
}
