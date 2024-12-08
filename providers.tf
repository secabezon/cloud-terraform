terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.43.0, <4.47.0, !=4.43.0"
    }
     random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
  required_version = "1.10.0"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}


