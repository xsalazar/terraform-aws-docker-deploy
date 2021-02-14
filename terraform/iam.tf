resource "aws_iam_role" instance {
  name = "lambda-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      Action : "sts:AssumeRole",
      Principal : {
        Service : "lambda.amazonaws.com"
      },
      Effect : "Allow"
    }]
  })
  tags = local.default_tags
}

resource "aws_iam_role_policy_attachment" instance {
  role       = aws_iam_role.instance.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_lambda_permission" lambda_root_permission {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.instance.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.instance.execution_arn}/*/*/"
}

resource "aws_lambda_permission" lambda_proxy_permission {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.instance.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.instance.execution_arn}/*/*/*"
}