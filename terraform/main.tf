provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./module/vpc"
  cidr_block = var.cidr_block
  project = var.project_name
  private_database_availability_zone = var.private_database_availability_zone
  private_availability_zone = var.private_availability_zone
  public_availability_zone = var.public_availability_zone
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  private_database_subnet_cidr = var.private_database_subnet_cidr
}

module "rds" {
  source = "./module/rds"
  db_name = var.db_name
  username = var.username
  password = var.password
  vpc_id = module.vpc.vpc_id
  private_db_subnet_ids = module.vpc.private_db_subnet_ids
  private_subnet = module.vpc.private_subnet
  depends_on = [ module.vpc ]
}

module "eks" {
  source = "./module/eks"
  project_name = var.project_name
  subnet_ids = concat(module.vpc.private_subnet, module.vpc.private_db_subnet_ids)
  desired_size = var.desired_size
  max_size = var.max_size
  min_size = var.min_size
  depends_on = [ module.vpc ]
}