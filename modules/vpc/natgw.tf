
# To save on the cost of an EIP, all private subnets are routing their traffic to one NAT Gateway.
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public)[0].id
  tags = merge(var.tags, { Name = "${var.environment_name}-nat" })
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat" {
  tags = merge(var.tags, { Name = "${var.environment_name}-nat-eip" })
}