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
