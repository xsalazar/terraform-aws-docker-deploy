terraform {
  required_version = "~> 1.1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.65.0"
    }
  }
  backend "s3" {
    bucket = "xsalazar-terraform-state"
    key    = "terraform-aws-docker-deploy/terraform.tfstate"
    region = "us-west-2"
  }
}

provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      CreatedBy = "terraform"
    }
  }
}

output "alb_dns" {
  value = aws_lb.instance.dns_name
}

output "ecr_repository_name" {
  value = aws_ecr_repository.instance.name
}
