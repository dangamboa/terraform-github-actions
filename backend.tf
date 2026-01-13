terraform {
  backend "s3" {
    bucket       = "terraform-github-actions-state-dangamboa"
    key          = "infra/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}