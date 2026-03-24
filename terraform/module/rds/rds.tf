resource "aws_db_instance" "titan-rds" {
 allocated_storage = 10
 db_name = "${var.db_name}"
 engine = "mariadb"
 engine_version = "11.8.5"
 instance_class = "db.t3.micro"
 username = var.username
 password = var.password
}