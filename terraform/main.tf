provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      Project = "laravel-ec2-code-deploy"
    }
  }
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

locals {
  app_name = "laravel-ec2-code-deploy"
}
