resource "aws_vpc" "titan_vpc" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "${var.project}-vpc"
  }
}

resource "aws_internet_gateway" "titan_igw" {
  vpc_id = aws_vpc.titan_vpc.id

  tags = {
    Name = "${var.project}-igw"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.titan_vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.public_availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-public-subnet"
  }
  depends_on = [ aws_vpc.titan_vpc ]
}

resource "aws_subnet" "public_subnet_secondary" {
  vpc_id                  = aws_vpc.titan_vpc.id
  cidr_block              = var.public_subnet_secondary_cidr
  availability_zone       = var.public_secondary_availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-public-subnet-secondary"
  }
  depends_on = [ aws_vpc.titan_vpc ]
}


resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.titan_vpc.id
  cidr_block = var.private_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone = var.private_availability_zone
  tags = {
    Name = "${var.project}-private-subnet"
  }
  depends_on = [ aws_vpc.titan_vpc ]
}

resource "aws_subnet" "private_subnet_database" {
  vpc_id = aws_vpc.titan_vpc.id
  cidr_block = var.private_database_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone = var.private_database_availability_zone
  tags = {
    Name = "${var.project}-private-database-subnet"
  }
  depends_on = [ aws_vpc.titan_vpc ]
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.titan_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.titan_igw.id
  }

  tags = {
    Name = "${var.project}-public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_secondary_association" {
  subnet_id      = aws_subnet.public_subnet_secondary.id
  route_table_id = aws_route_table.public_route_table.id
}
