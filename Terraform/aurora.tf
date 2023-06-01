resource "aws_db_instance" "aurora_instance" {
  allocated_storage = 10
  identifier        = "basic-aurora-instance"
  engine            = "postgres"
  # engine_version    = "14.1"
  instance_class    = "db.t3.micro"
  db_name           = "basicAuroraDb"
  username          = var.db_master_username
  password          = var.db_master_password
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.aurora_subnet_group.name
   vpc_security_group_ids = [aws_security_group.aurora_instance_sg.id]
}


resource "aws_db_subnet_group" "aurora_subnet_group" {
  # count = 1
  # name       = "aurora-subnet-group-${count.index+1}"
  name       = "aurora-subnet-group"
  subnet_ids = toset(concat(aws_subnet.public.*.id, aws_subnet.private.*.id))
}
