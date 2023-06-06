resource "aws_eip" "nat" {
  count = length(aws_subnet.public)

  domain = "vpc"

  tags = {
    Name = "nat-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat" {
  count = length(aws_subnet.public)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "nat-gw-${count.index + 1}"
  }

  depends_on = [
    aws_internet_gateway.main
  ]
}

