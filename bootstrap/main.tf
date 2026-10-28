# Batasi versi Terraform CLI yang boleh menjalankan kode ini
terraform {
  required_version = "~> 1.16" # >= 1.16, < 2.0

  # Provider = plugin yang menerjemahkan HCL jadi API call ke AWS
  required_providers {
    aws = {
      source  = "hashicorp/aws" # diunduh dari registry.terraform.io
      version = "~> 6.0"        # >= 6.0, < 7.0
    }
  }
}

# Konfigurasi provider: region mana yang dipakai untuk API call
provider "aws" {
  region = "ap-southeast-1"
}

# Email penerima alert, diisi lewat env var TF_VAR_alert_email (bukan hardcode)
variable "alert_email" {
  type = string
}

# Budget bulanan: kirim email kalau biaya aktual menembus 80% dari limit
resource "aws_budgets_budget" "monthly" {
  name         = "monthly-cost"
  budget_type  = "COST"
  limit_amount = "10"       # string, bukan angka — sesuai skema provider
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.alert_email]
  }
}
