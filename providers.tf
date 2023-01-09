terraform {
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend s3 {
    bucket = "terraform-test"
    key    = "demo"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}