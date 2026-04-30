provider "aws" {
  region = var.region
}

data "aws_eks_cluster" "this" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "this" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

module "s3_backend" {
  source      = "./module/s3_backend"
  bucket_name = var.tfstate_bucket_name
  environment = var.environment
}

module "vpc" {
  source = "./module/vpc"
  cidr_block = var.cidr_block
  project = var.project_name
  private_database_availability_zone = var.private_database_availability_zone
  private_availability_zone = var.private_availability_zone
  public_availability_zone = var.public_availability_zone
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_secondary_cidr = var.public_subnet_secondary_cidr
  public_secondary_availability_zone = var.public_secondary_availability_zone
  private_subnet_cidr = var.private_subnet_cidr
  private_database_subnet_cidr = var.private_database_subnet_cidr
}

module "rds" {
  source = "./module/rds"
  db_name = var.db_name
  username = var.username
  password = var.password
  vpc_id = module.vpc.vpc_id
  private_subnet = module.vpc.private_subnet_vpc
  depends_on = [ module.vpc ]
}

module "eks" {
  source = "./module/eks"
  project_name = var.project_name
  subnet_ids = module.vpc.public_subnet_ids
  vpc_id = module.vpc.vpc_id
  aws_region = var.region
  desired_size = var.desired_size
  max_size = var.max_size
  min_size = var.min_size
  depends_on = [ module.vpc ]
}
