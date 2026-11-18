output "vpc_id" {
  description = "ID VPC yang dibuat"
  value       = module.vpc.vpc_id # module.<nama_module>.<nama_output>
}

output "vpc_cidr_block" {
  description = "CIDR block VPC"
  value       = module.vpc.vpc_cidr_block
}
