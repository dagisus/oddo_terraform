output "db_address" {
  value = aws_rds_cluster.odoo.endpoint
}

output "db_port" {
  value = aws_rds_cluster.odoo.port
}

output "db_username" {
  value = var.db_username
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret.db.arn
}
