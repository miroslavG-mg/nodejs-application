resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main-public" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"

  tags = {
    Name = "main-public"
  }
}

resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "main-public"
  }
}

resource "aws_route_table_association" "main-public" {
  subnet_id = aws_subnet.main-public.id
  route_table_id = aws_route_table.main-public.id
}

