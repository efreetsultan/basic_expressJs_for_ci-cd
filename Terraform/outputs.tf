output "ecr_repository_url_server" {
  value       = aws_ecr_repository.repo1.repository_url
  description = "The URL of the ECR repository."
}

output "ecr_repository_url_client" {
  value       = aws_ecr_repository.repo2.repository_url
  description = "The URL of the ECR repository."
}

output "ecr_repository_arn_server" {
  value       = aws_ecr_repository.repo1.arn
  description = "The ARN of the ECR repository."
}

output "ecr_repository_arn_client" {
  value       = aws_ecr_repository.repo2.arn
  description = "The ARN of the ECR repository."
}

output "ecr_repository_name_server" {
  value       = aws_ecr_repository.repo1.name
  description = "The name of the ECR repository."
}

output "ecr_repository_name_client" {
  value       = aws_ecr_repository.repo2.name
  description = "The name of the ECR repository."
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC."
}

output "public_subnet_ids" {
  value       = aws_subnet.public.*.id
  description = "The IDs of the public subnets."
}

output "private_subnet_ids" {
  value       = aws_subnet.private.*.id
  description = "The IDs of the private subnets."
}

output "aurora_instance_endpoint" {
  value = aws_db_instance.aurora_instance.endpoint
}

output "bastion_host_ip" {
  value = aws_instance.bastion_host.public_ip
}

output "private_instance_ip" {
  value = aws_instance.private_instance.private_ip
}

output "current_account_id" {
  value = data.aws_caller_identity.current.account_id
}

# output "nodegroup_arn" {
#   value = aws_eks_node_group.workers[0].arn
# }

output "client_bucket" {
  value = aws_s3_bucket.react_app_bucket.bucket
}