
variable "cidr_block" {}

variable "vpc_name" {
  default = "titan-vpc"
}

variable "project" {
  default = "project-titan"
}

variable "public_subnet_cidr" {
  default = "10.10.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.10.10.0/24"
}

variable "private_database_subnet_cidr" {
  default = "10.10.20.0/24"
}

variable "private-availability-zone" {
  default = "eu-west-2a"
}

variable "private-database-availability-zone" {
  default = "eu-west-2b"
}

variable "public-availability-zone" {
  default = "eu-west-2c"
}