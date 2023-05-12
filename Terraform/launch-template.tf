resource "aws_launch_template" "this" {
  name_prefix   = "eks-node-group"
  image_id      = data.aws_ami.eks_worker.id
  instance_type = var.node_group_instance_type
  # key_name      = "your-key-pair-name"

  user_data = base64encode(templatefile("${path.module}/userdata.tpl", {
    cluster_name = var.cluster_name
    endpoint     = aws_eks_cluster.cluster.endpoint
    cluster_ca   = aws_eks_cluster.cluster.certificate_authority[0].data
  }))
}