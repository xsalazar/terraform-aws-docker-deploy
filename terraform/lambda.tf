resource "aws_lambda_function" instance {
  function_name    = "lambda-function"
  image_uri        = "368081326042.dkr.ecr.us-west-2.amazonaws.com/docker-test:latest"
  package_type     = "Image"
  role             = aws_iam_role.instance.arn
  handler          = "lambda.handler"
  runtime          = "nodejs12.x"
  tags             = local.default_tags
}