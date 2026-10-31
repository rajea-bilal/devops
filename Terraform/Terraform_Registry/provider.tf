# Sets up Terraform to work with AWS: which provider to use, its version requirements, and settings such as AWS region

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.68.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-rajea"
    key = "terraform.tfstate"
    region = "eu-north-1" // Where Terraform’s state bucket is located.
  }
}

provider "aws" {
  # Configuration options
  region = "eu-north-1" // Where Terraform manages your EC2 instances.
}

# backend "s3"	“Use Amazon S3 to store my state.”
# bucket	“Use this existing bucket.”
# key	“Save the state under this filename/path inside the bucket.”
# region	“The bucket is in this AWS region.”

# When you ran terraform init, Terraform:
# 1. Read the backend block in your .tf configuration.
# 2. Detected that you were switching from local storage to S3.
# 3. Found your existing local state, containing the records of your managed EC2 instances.
# 4. Found no state at the specified location in S3.
# 5. Asked whether to copy your existing records there.