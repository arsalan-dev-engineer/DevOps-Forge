resource "aws_ssm_parameter" "db_password" {
  name  = "/wordpress/db/password"
  type  = "SecureString"
  value = var.db_password
}
