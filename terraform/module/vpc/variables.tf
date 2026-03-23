
variable "cidr_block" {
    default = "10.10.10.0/16"
}

variable "vpc_name" {
  default = "titan-vpc"
}

variable "project" {
  default = "project-titan"
}

variable "public_subnet_cidr" {
  default = "10.10.14.0/24"
}

variable "private_subnet_cidr" {
  default = "10.10.18.4/24"
}