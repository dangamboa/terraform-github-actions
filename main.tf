#Simple test

# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create an S3 bucket
resource "aws_s3_bucket" "test_bucket" {
  bucket = "terraform-github-actions-dangamboa-test"
  tags = {
    Name = "ManagedByTerraform"
  }
}

#Output bucket name
output "bucket_name" {
  value = aws_s3_bucket.test_bucket.bucket
}