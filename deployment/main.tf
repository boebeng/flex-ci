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

resource "aws_amplify_app" "amplify_app" {
  name         = "flexci-ampl-test"
  repository   = "https://github.com/boebeng/flex-ci.git"
  access_token = var.REPO_TOKEN

  # The default build_spec added by the Amplify Console for React.
  build_spec = <<-EOT
    version: 0.1
    frontend:
      phases:
        preBuild:
          commands:
            - yarn install
        build:
          commands:
            - echo Here is my build
      artifacts:
        baseDirectory: ./
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT

  # The default rewrites and redirects added by the Amplify Console.
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

  environment_variables = {
    ENV = "develop"
  }
}

