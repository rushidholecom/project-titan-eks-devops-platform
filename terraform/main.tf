provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source = "./module/vpc"
  cidr_block = "198.16.0.0/16"
  project = "project-titan"
  private_database_availability_zone = "eu-west-2a"
}

module "rds" {
  source = "./module/rds"
  db_name = "titan_db"
  username = "rushi"
  password = "redhat1234"
  vpc_id = module.vpc.vpc_id
  private_db_subnet_ids = [module.vpc.private_db_subnet_ids, module.vpc.private_subnet]
  depends_on = [ module.vpc ]
}