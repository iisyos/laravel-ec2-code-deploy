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
  app_name           = "laravel-ec2-code-deploy"
  source_repo_name   = "laravel-ec2-code-deploy"
  source_repo_branch = "main"
  connection_arn     = "arn:aws:codeconnections:ap-northeast-1:235087485205:connection/0df39de9-93f3-43c0-838a-0409a9de42d2"
}
