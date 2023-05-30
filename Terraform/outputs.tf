output "ecr_repository_url" {
  value       = aws_ecr_repository.example.repository_url
  description = "The URL of the ECR repository."
}

output "ecr_repository_arn" {
  value       = aws_ecr_repository.example.arn
  description = "The ARN of the ECR repository."
}

output "ecr_repository_name" {
  value       = aws_ecr_repository.example.name
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

output "aurora_cluster_endpoint" {
  value = aws_rds_cluster.aurora_cluster.endpoint
}

