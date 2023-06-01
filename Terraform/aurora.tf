resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "basic-aurora-cluster"
  engine                  = "aurora-postgresql"
  master_username         = var.db_master_username
  master_password         = var.db_master_password
  database_name           = "basic_aurora_db"
  # availability_zones      = ["eu-west-2a", "eu-west-2b"]
  db_subnet_group_name = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.aurora_cluster_sg.id]
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  # count = 1
  # name       = "aurora-subnet-group-${count.index+1}"
  name       = "aurora-subnet-group"
  subnet_ids = toset(concat(aws_subnet.public.*.id, aws_subnet.private.*.id))
}


