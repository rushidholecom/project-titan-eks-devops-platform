resource "aws_vpc" "titan_vpc" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "${var.project}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.titan_vpc.id
  cidr_block = var.public_subnet_cidr
  tags = {
    Name = "${var.project}-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.titan_vpc.id
  cidr_block = var.private_subnet_cidr
  tags = "${var.project}-private-subnet"
}
