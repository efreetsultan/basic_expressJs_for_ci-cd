resource "tls_private_key" "terrafrom_generated_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "aws_keys_pairs"
  public_key = tls_private_key.terrafrom_generated_private_key.public_key_openssh

  # provisioner "local-exec" {
  #   command = "echo '${tls_private_key.terrafrom_generated_private_key.private_key_pem}' > ./aws_keys_pairs.pem"
  # }
}

resource "local_file" "private_key" {
  content  = tls_private_key.terrafrom_generated_private_key.private_key_pem
  filename = "aws_keys_pairs"
  file_permission = "0400"
}


resource "aws_eip" "bastion_eip" {
  domain     = "vpc"
  instance = aws_instance.bastion_host.id
}

resource "aws_instance" "bastion_host" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "aws_keys_pairs"
  subnet_id     = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "bastion-host"
  }
}

resource "aws_instance" "private_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "aws_keys_pairs"
  subnet_id     = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.private_instance_sg.id]

  tags = {
    Name = "private-instance"
  }

  depends_on = [aws_db_instance.aurora_instance]
}

resource "aws_eip_association" "bastion_eip_assoc" {
  instance_id   = aws_instance.bastion_host.id
  allocation_id = aws_eip.bastion_eip.id
}
