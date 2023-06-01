variable "ecr_repository_name" {
  type        = string
  description = "The name of the ECR repository."
}

variable "image_tag_mutability" {
  type        = string
  description = "The mutability of the image tags."
  default     = "MUTABLE"
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
}

variable "region" {
  description = "The AWS region to create the EKS cluster in."
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the EKS cluster."
  default     = "1.21"
}

variable "node_group_desired_capacity" {
  description = "The desired number of worker nodes in the node group."
  default     = 1
}

variable "node_group_min_size" {
  description = "The minimum number of worker nodes in the node group."
  default     = 1
}

variable "node_group_max_size" {
  description = "The maximum number of worker nodes in the node group."
  default     = 2
}

variable "node_group_instance_type" {
  description = "The instance type to use for the worker nodes in the node group."
  default     = "t3.medium"
}

variable "node_group_ami_type" {
  description = "The ami type to use for the worker nodes in the node group."
  default = "AL2_x86_64"
}

variable "worker_security_group_id" {
  description = "The ID of the security group for EKS worker nodes."
  default = "aws_subnet.private.*.id"
}

variable "worker_ingress_cidr_block" {
  description = "CIDR block to allow worker node ingress traffic."
  default     = "0.0.0.0/0"
}

variable "environment" {
  description = "The environment name, e.g. 'dev', 'staging', 'prod'."
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "The CIDR blocks for the public subnets."
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "The CIDR blocks for the private subnets."
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  type        = list(string)
  description = "The availability zones for the subnets."
  default     = ["eu-west-2a", "eu-west-2b"]
}

# variable "app_name" {
#   type        = string
#   description = "The name of the application."
# }

# variable "env_name" {
#   type        = string
#   description = "The name of the environment."
# }

variable "aws_region" {
  type        = string
  description = "The AWS region where the resources will be created."
  default     = "eu-west-2"
}

variable "db_master_username" {
  description = "Master username for the database"
  type        = string
}

variable "db_master_password" {
  description = "Master password for the database"
  type        = string
}