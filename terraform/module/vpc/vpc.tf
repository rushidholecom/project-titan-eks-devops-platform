resource "aws_vpc" "titan_vpc" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "${var.project}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = "${aws_vpc.titan_vpc.id}"
  cidr_block = var.public_subnet_cidr
  availability_zone = var.public-availability-zone
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.project}-public-subnet"
  }
  depends_on = [ aws_vpc.titan_vpc ]
}


resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.titan_vpc.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone = var.private-availability-zone
  tags = {
    Name = "${var.project}-public-subnet"
  }
  depends_on = [ aws_vpc.titan_vpc ]
}

resource "aws_subnet" "private_subnet-database" {
  vpc_id = "${aws_vpc.titan_vpc.id}"
  cidr_block = var.private_database_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone = var.private-database-availability-zone
  tags = {
    Name = "${var.project}-private-subnet"
  }
  depends_on = [ aws_vpc.titan_vpc ]
}
