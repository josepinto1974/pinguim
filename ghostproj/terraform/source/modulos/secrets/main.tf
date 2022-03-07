resource "aws_secretsmanager_secret" "secrets_rds" {
  name = var.name_secrets
}




resource "aws_secretsmanager_secret_version" "rdspassword" {
  secret_id     = aws_secretsmanager_secret.secrets_rds.id
  secret_string = var.rdspassword
}