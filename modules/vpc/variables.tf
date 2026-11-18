variable "vpc_cidr" {
  type        = string
  description = "CIDR block untuk VPC"
  # Sengaja tanpa default: pemanggil WAJIB isi
}

variable "name" {
  type        = string
  description = "Nama VPC, dipakai di tag Name (contoh: learn-terraform-dev)"
  # Tanpa default, sama seperti vpc_cidr: setiap environment wajib kasih nama sendiri
}
