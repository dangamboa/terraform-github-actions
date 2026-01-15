terraform {
  backend "s3" {
    bucket       = var.s3_bucket
    key          = "infra/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}