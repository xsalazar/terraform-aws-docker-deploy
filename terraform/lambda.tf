resource "aws_lambda_function" instance {
  function_name    = "lambda-function"
  image_uri        = join(":", [data.aws_ecr_repository.instance.repository_url, data.aws_ecr_image.instance.image_tag])
  package_type     = "Image"
  role             = aws_iam_role.instance.arn
  source_code_hash = split(":", data.aws_ecr_image.instance.image_digest)[1]
  tags             = local.default_tags
}