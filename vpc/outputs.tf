output "vpc_id" {
  description = "ID VPC yang dibuat"
  value       = aws_vpc.main.id # <tipe>.<nama_lokal>.<atribut>
}

output "vpc_cidr_block" {
  description = "CIDR block VPC"
  value       = aws_vpc.main.cidr_block
}
