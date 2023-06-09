resource "aws_iam_role" "cluster" {
  name               = "eksClusterRoleNew"
  assume_role_policy = data.aws_iam_policy_document.cluster_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "cluster_policy_attachment" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "node" {
  name               = "eksNodeRole"
  assume_role_policy = data.aws_iam_policy_document.node_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "node_policy_attachment" {
  for_each   = local.node_policy_arns
  role       = aws_iam_role.node.name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "additional_policy_attachment" {
  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}
