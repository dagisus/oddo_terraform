resource "aws_db_instance" "odooDB_terra" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = var.dbversion
  instance_class       = var.rds_instance_type
  name                 = "postgres"
  username             = var.dbuser
  password             = var.dbpassword
  db_subnet_group_name = aws_db_subnet_group.main_bd_subnet_group.name

  publicly_accessible     = "false"
  vpc_security_group_ids  = [aws_security_group.odooDBSG_terra.id]
  backup_retention_period = "0"
  skip_final_snapshot     = true
  identifier              = "odoodb-terra"
}

output "db_address" {
  value = aws_db_instance.odooDB_terra.address
}

output "db_user" {
  value = var.dbuser
}

output "db_password" {
  value = var.dbpassword
}

