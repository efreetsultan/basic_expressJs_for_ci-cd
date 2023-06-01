resource "aws_secretsmanager_secret" "aurora_db_credentials" {
  name = "aurora-db-credentials-new"
}

resource "aws_secretsmanager_secret_version" "aurora_db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.aurora_db_credentials.id
  secret_string = jsonencode({
    DB_USERNAME = var.db_master_username,
    DB_PASSWORD = var.db_master_password
  })
}
