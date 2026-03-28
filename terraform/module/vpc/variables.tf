
variable "cidr_block" {}

variable "vpc_name" {
  default = "titan-vpc"
}

variable "project" {}

variable "public_subnet_cidr" {
  default = "198.16.0.0/20"
}

variable "private_subnet_cidr" {
  default = "198.16.16.0/20"
}

variable "private_database_subnet_cidr" {
  default = "198.16.32.0/20"
}

variable "private_availability_zone" {}

variable "private_database_availability_zone" {}

variable "public_availability_zone" {}

output "vpc_id" {
  value = aws_vpc.titan_vpc.id
}

output "private_db_subnet_ids" {
 value = aws_subnet.private_subnet_database.id 
}

output "private_subnet" {
  value = aws_subnet.private_subnet.id
}

