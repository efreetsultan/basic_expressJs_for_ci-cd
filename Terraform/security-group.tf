resource "aws_security_group" "aurora_cluster_sg" {
  name        = "aurora-cluster-sg"
  description = "Security group for Aurora cluster"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}