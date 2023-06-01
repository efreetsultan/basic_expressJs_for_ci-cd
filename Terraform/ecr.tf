resource "aws_ecr_repository" "repo1" {
  name = "${var.ecr_repository_name}_server"

  image_tag_mutability = "MUTABLE"

  tags = {
    Name = "example"
  }
}

resource "aws_ecr_repository" "repo2" {
  name = "${var.ecr_repository_name}_client"

  image_tag_mutability = "MUTABLE"

  tags = {
    Name = "example"
  }
}
