region = "eu-west-2"
tfstate_bucket_name = "project-titan-terraform-state-demo"
environment         = "dev"

# VPC
cidr_block                         = "198.16.0.0/16"
private_database_availability_zone = "eu-west-2b"
private_availability_zone          = "eu-west-2a"
public_availability_zone           = "eu-west-2c"
public_subnet_cidr                 = "198.16.0.0/20"
public_secondary_availability_zone = "eu-west-2a"
public_subnet_secondary_cidr       = "198.16.48.0/20"
private_subnet_cidr                = "198.16.16.0/20"
private_database_subnet_cidr       = "198.16.32.0/20"

# RDS
db_name  = "titan_db"
username = "rushi"
password = "redhat1234"

# EKS
desired_size = 1
max_size     = 2
min_size     = 1
project_name = "project-titan"
