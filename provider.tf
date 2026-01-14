# Configure the AWS provider
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      description = "Managed by Terraform"
      repo        = "https://github.com/dangamboa/terraform-github-actions"
    }
  }
}