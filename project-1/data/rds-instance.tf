resource "aws_db_instance" "mydb" {
  identifier        = "my-rds-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  publicly_accessible = false

  db_name           = "myappdb"
  username          = "admin"
  password          = "SuperSecretPassword123!" # best to use SSM or Secrets Manager instead

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = var.db_subnet_group

  multi_az               = true
  skip_final_snapshot    = true

  tags = {
    Name = "my-rds-db"
  }
}
