output "rds_endpoint" {
  description = "RDS hostname for the Kubernetes backend ConfigMap."
  value       = module.rds.rds_endpoint
}

output "rds_port" {
  description = "RDS port for the Kubernetes backend ConfigMap."
  value       = module.rds.rds_port
}

output "rds_db_name" {
  description = "RDS database name for the Kubernetes backend ConfigMap."
  value       = module.rds.rds_db_name
}

output "rds_username" {
  description = "RDS username for backend connection."
  value       = module.rds.rds_username
  sensitive   = true
}

output "rds_password" {
  description = "RDS password for backend connection."
  value       = module.rds.rds_password
  sensitive   = true
}

output "eks_cluster_name" {
  description = "EKS cluster name for kubectl configuration."
  value       = module.eks.cluster_name
}

output "aws_region" {
  description = "AWS region used by Terraform."
  value       = var.region
}
