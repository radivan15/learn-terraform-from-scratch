# Learn Terraform From Scratch

Hands-on Terraform learning journey — from a single VPC to a production-grade, multi-environment AWS network module.

> Status: work in progress.

---

## What it does

Documents a step-by-step path through Terraform on AWS — starting with a single VPC, then refactoring it into a reusable module with a multi-environment folder structure and remote state, adding real networking, then production-grade practices.

---

## Why I'm building it

6 years of SRE/Cloud Engineering background, but I'm returning to work after a 5-year break — this rebuilds the Terraform mental model from the ground up, stage by stage, instead of relying on rusty muscle memory. The roadmap deliberately mirrors what a real SRE/Cloud Engineer role needs in production: modules, remote state, multi-environment structure, CI/CD with OIDC — not a single `main.tf` that never gets touched again.

---

## Stack

| Layer | Tool |
|---|---|
| IaC | Terraform ~> 1.16 | 
| Provider | hashicorp/aws ~> 6.0, hashicorp/random (Stage 16) |
| Cloud provider | AWS (VPC, IAM, CloudWatch, S3, SSM Parameter Store) |
| Remote state | S3 backend with native locking (`use_lockfile`) |
| CI/CD | GitHub Actions (OIDC to AWS — no long-lived keys) |
| Linting / scanning | tflint, trivy |
| Docs | terraform-docs |
| Testing | `terraform test` (native), Terratest in Go (bonus) |

---

## Folder Structure

Current state (Stage 1 in progress) — the layout will change in Stage 2 (modules) and Stage 3 (`environments/`).

```
learn-terraform-from-scratch/
├── bootstrap/          # AWS Budgets alert — own state, not destroyed with the VPC
│   └── main.tf
├── vpc/                # first VPC — provider, aws_vpc, variables
│   ├── main.tf
│   └── variables.tf
├── ROADMAP.md
└── README.md
```

---

## Installation

not available yet.

---

## Roadmap

Detailed execution roadmap is in [ROADMAP.md](ROADMAP.md).
