provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source = "./module/vpc"
  cidr_block = "10.10.0.0/16"
}
