data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_ami" "ubuntu" {

    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

# data "aws_ami" "eks_worker" {
#   filter {
#     name   = "name"
#     values = ["amazon-eks-node-*"]
#   }

#   most_recent = true
#   owners      = ["602401143452"]
# }

data "aws_iam_policy_document" "node_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "cluster_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "allow_access_from_current_account" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.react_app_bucket.arn,
      "${aws_s3_bucket.react_app_bucket.arn}/*",
    ]
  }
}

data "aws_security_group" "eks_node_group_sg" {
  filter {
    name   = "group-name"
    values = ["eks-cluster-sg-eks-*"]
  }
}