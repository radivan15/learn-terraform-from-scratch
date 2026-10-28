# Roadmap — Learning Terraform

## Phase 1 — Foundations
> Get a single VPC running, then turn it into something reusable

- [x] Stage 1 — AWS Budgets alert, then initial VPC setup
  - [x] AWS Budgets alert in a separate `bootstrap/` folder with its own state (safety net first)
  - [x] VPC in `vpc/`: provider with `default_tags`, `aws_vpc`, DNS settings
  - [x] Input variables (`region`, `vpc_cidr`)
  - [x] Outputs
  - [x] First `apply` + `destroy` of the VPC
- [ ] Stage 2 — Move VPC resource into a reusable module (`moved` block for zero-downtime state migration)
- [ ] Stage 3 — Multi-environment folder structure (`environments/dev` + `environments/prod`, separate state per folder, committed `terraform.tfvars`)
- [ ] Stage 4 — Remote state with S3 backend (native locking via `use_lockfile`, no DynamoDB table)

## Phase 2 — Networking
> Public/private subnets and real routing

- [ ] Stage 5 — Data sources (account ID, region, AZs)
- [ ] Stage 6 — Locals and public/private subnets
- [ ] Stage 7 — Internet Gateway & public route table
- [ ] Stage 8 — NAT Gateway & private route table (conditional per environment: single NAT in dev, one per AZ in prod)
- [ ] Stage 9 — VPC Flow Logs (CloudWatch Logs + IAM Role)
- [ ] Stage 10 — VPC Endpoints (S3 Gateway + Interface)

## Phase 3 — Production-Grade Practices
> Validation, tagging, and safeguards a real team would require

- [ ] Stage 11 — Variable validation, `deprecated` inputs/outputs & full outputs
- [ ] Stage 12 — Tagging strategy (required tags, naming convention)
- [ ] Stage 13 — Lifecycle & production safeguards (`prevent_destroy`, `destroy = false`)
- [ ] Stage 14 — Cross-environment remote state references
- [ ] Stage 15 — `check` blocks for post-plan/apply invariants
- [ ] Stage 16 — Ephemeral resources & write-only arguments (standalone lab: ephemeral `random_password` → `aws_ssm_parameter` `value_wo`, since the VPC has no secrets)

## Phase 4 — Advanced HCL
> Language features for handling variation cleanly

- [ ] Stage 17 — Dynamic blocks
- [ ] Stage 18 — Explicit `depends_on` review
- [ ] Stage 19 — Declarative `import`, `moved` & `removed` blocks, plus `terraform query` to discover existing resources

## Phase 5 — Testing & CI/CD
> Prove it works automatically, every time

- [ ] Stage 20 — Native testing with `terraform test` (`.tftest.hcl`)
- [ ] Stage 21 — CI/CD pipeline (GitHub Actions + OIDC to AWS, third-party actions pinned to commit SHA)
- [ ] Stage 22 — Tooling (`tflint`, `trivy`, `terraform-docs`) & final README

## Bonus (optional)

- [ ] Integration testing with Terratest (Go)

### Production-level tooling to explore later (not scheduled yet)

- [ ] Cost estimation in CI with Infracost
- [ ] Policy-as-code with Checkov + OPA/Conftest
- [ ] Scheduled drift detection (`terraform plan` on a cron in CI — dedicated drift tools like driftctl are unmaintained)
- [ ] Terragrunt for DRY multi-environment config
- [ ] Module versioning via pinned git tags (`?ref=vX.Y.Z`)

## Conventions

- Never commit `.tfstate` files, or `*.tfvars` other than `terraform.tfvars` (non-secret values only) — already covered by `.gitignore`
- Set `required_version = "~> 1.16"` in `terraform {}` — `deprecated` (1.15) and `terraform query` (1.14) fail on older versions
- Always commit `.terraform.lock.hcl` — pins provider versions and checksums so local and CI stay identical
- AWS Budgets alert is set up in Stage 1 via `bootstrap/` (separate state from the VPC, so the daily `destroy` of the VPC doesn't remove it) — a forgotten `destroy` should trigger an email, not a surprise bill
- Always run `terraform plan` before `apply` — never apply blind
- **Always run `terraform destroy` when done for the day** — NAT Gateway and VPC Endpoints cost money even when idle
