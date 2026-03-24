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
  vpc_id = module.vpc.vpc_id
  private_db_subnet = module.vpc.private_db_subnet
  depends_on = [ module.vpc ]
}