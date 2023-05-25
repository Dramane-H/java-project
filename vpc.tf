# 1. create vpc for my project

resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "production"
  }
}

# 2. create an Internet Gateway

resource "aws_internet_gateway" "int_gw" {
  # int-gw standing for internet gateway
  vpc_id = aws_vpc.prod-vpc.id
}

# 3. create custom route table
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod-vpc.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.int_gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.int_gw.id
  }

  
}