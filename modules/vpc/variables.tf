variable "vpc_cidr" {
  type        = string
  description = "CIDR block untuk VPC"
  # Sengaja tanpa default: pemanggil WAJIB isi
}
