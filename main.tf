resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "VPC-${var.tag}"
  }
}

# Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.pub_subnet_cidr
  availability_zone = var.av_zones.1
  tags = {
    Name = "Public-${var.tag}"
  }
}

# Create Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.prv_subnet_cidr
  availability_zone = var.av_zones.2
  tags = {
    Name = "Private-${var.tag}"
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Internet-${var.tag}"
  }
}

# # NAT Gateway
# resource "aws_nat_gateway" "nat_gateway" {
#   connectivity_type = "private"
#   subnet_id         = aws_subnet.private_subnet.id
#   tags = {
#     Name = "NAT-${var.tag}"
#   }
# }

# Creating Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public-${var.tag}-Table"
  }
}