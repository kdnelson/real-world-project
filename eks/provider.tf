terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }

  backend "s3" {
    bucket = "tfstate-dev-us-west-2-d51gzn"
    key = "eks/dev/terraform.tfstate"
    region = "us-west-2"
    encrypt = true
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region
  profile = "default"  # References your local ~/.aws/credentials file
}