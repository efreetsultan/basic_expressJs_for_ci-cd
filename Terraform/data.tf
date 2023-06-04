data "http" "my_ip" {
  url = "http://checkip.amazonaws.com/"
}

data "aws_ami" "ubuntu" {
    most_recent = "true"
    filter {
        name = "name"
        values = ["ubuntu/images/hvs-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
    owners = ["099720109477"]
}

data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI account ID
}

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