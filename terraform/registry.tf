resource "aws_ecr_repository" instance {
  name = "ecr-repository"
  tags = local.default_tags
}

data "aws_ecr_repository" instance {
  name = aws_ecr_repository.instance.name
}

data "aws_ecr_image" instance {
  repository_name = aws_ecr_repository.instance.name
  image_tag = "latest"
}