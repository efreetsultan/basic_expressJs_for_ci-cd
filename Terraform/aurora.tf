resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "basic-aurora-cluster"
  engine                  = "aurora-postgresql"
  engine_version          = "12.6"
  master_username         = db_master_username
  master_password         = db_master_password
  database_name           = "basic_aurora_db"

  availability_zones      = ["eu-west-2a", "eu-west-2b"]
  database_subnet_group_name = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.aurora_cluster_sg.id]
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = aws_subnet.public[count.index].id
}


