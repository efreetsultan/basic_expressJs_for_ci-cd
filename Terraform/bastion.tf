resource "aws_key_pair" "bastion" {
  key_name   = "bastion-key"
  public_key = file("../bastion")
}

resource "aws_eip" "bastion_eip" {
  vpc                = true
  instance           = aws_instance.bastion_host.id
}

resource "aws_instance" "bastion_host" {
  ami           = data.aws_ami.ubuntu
  instance_type = "t2.micro"
  key_name      = aws_key_pair.bastion.key_name
  subnet_id     = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "bastion-host"
  }

  network_interface {
    device_index         = 0
    associate_public_ip_address = true
    network_interface_id = aws_eip.bastion_eip.network_interface_id
  }
}

resource "aws_instance" "private_instance" {
  ami           = data.aws_ami.ubuntu
  instance_type = "t2.micro"
  key_name      = aws_key_pair.bastion.key_name
  subnet_id     = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.private_instance_sg.id]

  tags = {
    Name = "private-instance"
  }

  depends_on = [aws_db_instance.aurora_instance]
}
