terraform {
  backend "s3" {
    bucket         = "boebeng-flexci-global"
    key            = "flexci-demo-"
    region         = "eu-central-1"
    dynamodb_table = "aws-locks"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}


