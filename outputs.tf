output "server_domain" {
  value = module.compute.server_domain
}

output "ssh_command" {
  value = module.compute.ssh_command
}

output "web_url" {
  value = module.compute.web_url
}

output "db_address" {
  value = module.database.db_address
}

output "db_user" {
  value = module.database.db_username
}

output "db_secret_arn" {
  value = module.database.db_secret_arn
}
