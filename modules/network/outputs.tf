output "vpc_id" {
  value = local.vpc_id
}

output "public_subnet_id" {
  value = local.public_subnet_id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.this.name
}

output "app_security_group_id" {
  value = aws_security_group.app.id
}

output "db_security_group_id" {
  value = aws_security_group.db.id
}
