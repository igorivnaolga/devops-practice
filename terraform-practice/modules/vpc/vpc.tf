resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.vpc_name}-vpc"
  }
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igv"
  }
}

#resource "aws_security_group" "main" {
#  count       = length(var.security_group)
#  name        = "${var.vpc_name}-sg-${count.index + 1}"
#  description = "DB sg"
#  vpc_id      = aws_vpc.main.id
#
#  tags = {
#    Name = "db_sg"
#  }
#}
#
#resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
#  security_group_id = aws_security_group.main.id
#  cidr_ipv4         = aws_vpc.main.cidr_block
#  from_port         = 443
#  ip_protocol       = "tcp"
#  to_port           = 443
#}
#
#resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#  security_group_id = aws_security_group.main.id
#  cidr_ipv4         = "0.0.0.0/0"
#  ip_protocol       = "-1" # semantically equivalent to all ports
#}

#resource "aws_eip" "nat_eip" {
#  tags = {
#    Name = "${var.vpc_name}-nat-eip"
#  }
#}
#
#resource "aws_nat_gateway" "main" {
#  subnet_id = aws_subnet.public[0].id
#  allocation_id = aws_eip.nat_eip.id
#
#  tags = {
#    Name = "${var.vpc_name}-nat-gw"
#  }
#
#  depends_on = [aws_internet_gateway.main]
#}