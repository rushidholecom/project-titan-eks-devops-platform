#EKS
variable "project_name" {}

variable "subnet_ids" {
    type = list(string)
}

variable "desired_size" {}

variable "max_size" {}

variable "min_size" {}

variable "env" {
  default = "dev"
}

#RDS

variable "db_name" {}

variable "username" {}

variable "password" {}

variable "vpc_id" {}

variable "private_db_subnet_ids" {
    type = list(string)
}

variable "private_subnet" {
  
}

#vpc

variable "cidr_block" {}

variable "vpc_name" {
  default = "titan-vpc"
}

variable "project" {}

variable "public_subnet_cidr" {
  #default = "198.16.0.0/20"
}

variable "private_subnet_cidr" {
  #default = "198.16.16.0/20"
}

variable "private_database_subnet_cidr" {
  #default = "198.16.32.0/20"
}

variable "private_availability_zone" {}

variable "private_database_availability_zone" {}

variable "public_availability_zone" {}

# output "vpc_id" {
#   value = aws_vpc.titan_vpc.id
# }

# output "private_db_subnet_ids" {
#  value = aws_subnet.private_database_subnet.id
# }

# output "private_subnet" {
#   value = aws_subnet.private_subnet.id
# }

variable "region" {
  
}

variable "private_db_subnet_ids" {
  
}

variable "private_subnet" {
  
}