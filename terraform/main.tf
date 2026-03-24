provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source = "./module/vpc"
  cidr_block = "10.10.0.0/16"
  project = "project-titan"
}

module "rds" {
  source = "./module/rds"
  db_name = "titan-db"
  username = "rushi"
  password = "redhat"
  depends_on = [ module.vpc ]
}