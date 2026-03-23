resource "aws_vpc" "titan_vpc" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "titan-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.titan_vpc
  cidr_block = "10.10.14.0/24"
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.titan_vpc
  cidr_block = "10.10.18.4/24"
}
