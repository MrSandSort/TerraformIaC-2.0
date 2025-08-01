resource "aws_vpc" "sand_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "sandesh_vpc"
  }
}

resource "aws_subnet" "sand_public_subnet" {
  depends_on              = [aws_vpc.sand_vpc]
  vpc_id                  = aws_vpc.sand_vpc.id
  availability_zone       = var.zone
  cidr_block              = var.public_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "sandesh-public-subnet-01"
  }
}

resource "aws_subnet" "sand_private_subnet" {
  depends_on              = [aws_vpc.sand_vpc]
  vpc_id                  = aws_vpc.sand_vpc.id
  availability_zone       = var.zone
  cidr_block              = var.private_cidr
  map_public_ip_on_launch = false

  tags = {
    Name = "sandesh-private-subnet-01"
  }
}

resource "aws_internet_gateway" "sand_igw" {
  vpc_id = aws_vpc.sand_vpc.id
  depends_on = [
    aws_vpc.sand_vpc,
    aws_subnet.sand_public_subnet,
    aws_subnet.sand_private_subnet
  ]
  tags = {
    Name = "sandesh_internet_gateway"
  }
}

resource "aws_eip" "nat_ip" {
  vpc = true
}

resource "aws_nat_gateway" "sand_ngw" {
  depends_on    = [aws_internet_gateway.sand_igw]
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.sand_public_subnet.id

  tags = {
    Name = "sandesh-nat-gateway"
  }
}

resource "aws_route_table" "sand_public_routes" {
  vpc_id = aws_vpc.sand_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sand_igw.id
  }

  tags = {
    Name = "sandesh-public-route-table"
  }
}

resource "aws_route_table" "sand_private_routes" {
  vpc_id = aws_vpc.sand_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.sand_ngw.id
  }

  tags = {
    Name = "sandesh-private-route-table"
  }
}

resource "aws_route_table_association" "pub" {
  route_table_id = aws_route_table.sand_public_routes.id
  subnet_id      = aws_subnet.sand_public_subnet.id
}

resource "aws_route_table_association" "priv" {
  route_table_id = aws_route_table.sand_private_routes.id
  subnet_id      = aws_subnet.sand_private_subnet.id
}
