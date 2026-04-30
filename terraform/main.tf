terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
  }
}

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
  kubernetes = {
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
  desired_size = var.desired_size
  max_size = var.max_size
  min_size = var.min_size
  depends_on = [ module.vpc ]
}

resource "kubernetes_service_account_v1" "aws_load_balancer_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = module.eks.aws_load_balancer_controller_role_arn
    }
    labels = {
      "app.kubernetes.io/name" = "aws-load-balancer-controller"
    }
  }

  depends_on = [module.eks]
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set = [
    {
      name  = "clusterName"
      value = module.eks.cluster_name
    },
    {
      name  = "serviceAccount.create"
      value = "false"
    },
    {
      name  = "serviceAccount.name"
      value = kubernetes_service_account_v1.aws_load_balancer_controller.metadata[0].name
    },
    {
      name  = "region"
      value = var.region
    },
    {
      name  = "vpcId"
      value = module.vpc.vpc_id
    }
  ]

  depends_on = [
    module.eks,
    kubernetes_service_account_v1.aws_load_balancer_controller
  ]
}
