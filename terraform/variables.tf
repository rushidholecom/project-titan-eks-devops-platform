variable "project_name" {}

variable "tfstate_bucket_name" {}

variable "environment" {
  default = "dev"
}

variable "desired_size" {}

variable "max_size" {}

variable "min_size" {}

variable "db_name" {}

variable "username" {}

variable "password" {}

variable "cidr_block" {}

variable "public_subnet_cidr" {}

variable "public_subnet_secondary_cidr" {}

variable "private_subnet_cidr" {}

variable "private_database_subnet_cidr" {}

variable "private_availability_zone" {}

variable "private_database_availability_zone" {}

variable "public_availability_zone" {}

variable "public_secondary_availability_zone" {}

variable "region" {}
