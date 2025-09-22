output "db_endpoint" {
  value = aws_db_instance.mydb.endpoint
}

output "db_name" {
  value = aws_db_instance.mydb.db_name
}
