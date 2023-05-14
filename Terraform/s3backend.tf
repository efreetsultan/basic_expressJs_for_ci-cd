terraform {
  backend "s3" {
    bucket         = "${var.app_name}-${var.env_name}"
    key            = "terraform.tfstate"
    region         = "${var.aws_region}"
    dynamodb_table = "${var.app_name}-${var.env_name}"
    encrypt        = true
  }
}
