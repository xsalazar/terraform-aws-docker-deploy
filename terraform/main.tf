locals {
  default_tags = {
    "automation" = "terraform"
  }
}

provider "aws" {
  region = var.region
}

output api_endpoint {
  value = aws_api_gateway_deployment.instance.invoke_url
}
