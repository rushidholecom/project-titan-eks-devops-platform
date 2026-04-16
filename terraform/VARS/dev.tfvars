region = "eu-west-2"

#VPC

  cidr_block = "198.16.0.0/16"
  project = "project-titan"
  private_database_availability_zone = "eu-west-2b"
  private_availability_zone = "eu-west-2a"
  public_availability_zone = "eu-west-2c"
  public_subnet_cidr = "198.16.0.0/20"
  private_subnet_cidr = "198.16.16.0/20"
  private_database_subnet_cidr = "198.32.16.0/20"
  private_db_subnet_ids = ["var.private_db_subnet_ids"] 
  private_subnet = "var.private_subnet"

#RDS

  db_name = "titan_db"
  username = "rushi"
  password = "redhat1234"

#EKS

  desired_size = 2
  max_size = 2
  min_size = 1
  project_name = "project-titan"
