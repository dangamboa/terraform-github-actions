variable "aws_region" {
  type        = string
  description = "AWS Region to deploy resources"
  default     = "us-east-1"
}

variable "s3_bucket" {
  type        = string
  description = "S3 bucket used for this project, must be created beforehand"
  default     = "terraform-github-actions-dangamboa"
}