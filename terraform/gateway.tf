resource "aws_api_gateway_rest_api" instance {
  name = "api-gateway"
  body = templatefile("${path.module}/templates/api-gateway.yaml.tpl", {
    api_title   = "api-gateway"
    lambda_name = aws_lambda_function.instance.function_name
    region      = var.region
    account_id  = var.account_id
  })

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" instance {
  rest_api_id = aws_api_gateway_rest_api.instance.id
  stage_name  = "active"

  lifecycle {
    create_before_destroy = true
  }
}
