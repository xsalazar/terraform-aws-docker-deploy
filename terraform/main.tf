locals {
  default_tags = {
    "automation" = "terraform"
  }
}

provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "xsalazar-terraform-state"
    key    = "aws-docker/terraform.tfstate"
    region = "us-west-2"
  }
}

output api_endpoint {
  value = aws_api_gateway_deployment.instance.invoke_url
}
