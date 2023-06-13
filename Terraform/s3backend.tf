terraform {
  backend "s3" {
    bucket         = "placeholder"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "somebucketformythings"
    encrypt        = true
  }
}
