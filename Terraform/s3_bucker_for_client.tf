resource "aws_s3_bucket" "react_app_bucket" {
  bucket = var.s3_client
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Name = "React App Bucket"
  }
}
