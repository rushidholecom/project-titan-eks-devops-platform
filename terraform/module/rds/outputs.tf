output "rds_endpoint" {
  description = "RDS hostname for application connections."
  value       = aws_db_instance.titan_rds.address
}

output "rds_port" {
  description = "RDS port for application connections."
  value       = aws_db_instance.titan_rds.port
}

output "rds_db_name" {
  description = "Initial database name created in RDS."
  value       = aws_db_instance.titan_rds.db_name
}
