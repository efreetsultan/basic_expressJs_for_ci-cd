resource "aws_ecr_repository" "example" {
  name = var.ecr_repository_name

  image_tag_mutability = "MUTABLE"

  tags = {
    Name = "example"
  }
}
