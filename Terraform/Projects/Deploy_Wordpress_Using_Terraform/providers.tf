terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.68.0"
    }
  }

}

// settings for the required provider
provider "aws" {
  # Configuration options
  region = "eu-north-1" // Where Terraform manages your EC2 instances.
}