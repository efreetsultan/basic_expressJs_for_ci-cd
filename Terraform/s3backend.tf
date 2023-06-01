terraform {
  backend "s3" {
    bucket         = "somebucketformythings"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "somebucketformythings"
    encrypt        = true
  }
}
