
variable "cidr_block" {}

variable "vpc_name" {
  default = "titan-vpc"
}

variable "project" {}

variable "public_subnet_cidr" {
  default = "10.10.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.10.2.0/24"
}

variable "private_database_subnet_cidr" {
  default = "10.10.3.0/24"
}

variable "private_availability_zone" {
  default = "eu-west-2a"
}

variable "private_database_availability_zone" {}

variable "public_availability_zone" {
  default = "eu-west-2c"
}

output "vpc_id" {
  value = aws_vpc.titan_vpc.id
}

output "private_db_subnet_ids" {
 value = aws_subnet.private_subnet-database.id  
}