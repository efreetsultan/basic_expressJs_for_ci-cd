resource "aws_eks_node_group" "workers" {
  cluster_name    = var.cluster_name
  node_group_name = "workers"
  node_role_arn = aws_iam_role.node.arn


  scaling_config {
    desired_size = var.node_group_desired_capacity
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }

  subnet_ids = aws_subnet.private.*.id

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }

  depends_on = [
    aws_eks_cluster.cluster,
  ]

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }
}