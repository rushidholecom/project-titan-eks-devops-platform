output "vpc_id" {
  value = aws_vpc.titan_vpc.id
}

output "private_db_subnet_ids" {
 value = [aws_subnet.private_subnet_database.id,aws_subnet.private_subnet_database.id]
}

output "private_subnet" {
  value = [aws_subnet.private_subnet.id,aws_subnet.private_subnet_database.id]
}

output "private_subnet_vpc" {
  value = [aws_subnet.private_subnet.id,aws_subnet.private_subnet_database.id]
}
