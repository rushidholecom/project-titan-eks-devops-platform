resource "aws_db_instance" "titan_rds" {
 allocated_storage = 10
 db_name = "${var.db_name}"
 engine = "mariadb"
 engine_version = "11.8.5"
 instance_class = "db.t3.micro"
 username = var.username
 password = var.password
 
}

resource "aws_security_group" "mariadb_security_group" {
  name = "mariadb_security_group"
  vpc_id = var.vpc_id.vpv_id
  description = "Allow Mariadb access"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "mariadb_subnet_group" {
  name = "db-subnet-group"
  subnet_ids = [var.private_subnet.id]
}