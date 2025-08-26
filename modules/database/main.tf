resource "aws_rds_cluster" "odoo" {
  engine               = "aurora-postgresql"
  engine_version       = var.engine_version
  master_username      = var.db_username
  master_password      = var.db_password
  db_subnet_group_name = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  skip_final_snapshot  = true
}

resource "aws_rds_cluster_instance" "odoo" {
  count              = 1
  cluster_identifier = aws_rds_cluster.odoo.id
  instance_class     = var.instance_type
  db_subnet_group_name = var.db_subnet_group_name
  publicly_accessible = false
  availability_zone   = var.availability_zones[0]
}

resource "aws_secretsmanager_secret" "db" {
  name = "odoo-db-credentials"
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id     = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = aws_rds_cluster.odoo.endpoint
    port     = aws_rds_cluster.odoo.port
    dbname   = "postgres"
  })
  depends_on = [aws_rds_cluster.odoo]
}
