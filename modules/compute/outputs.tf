output "server_domain" {
  value = aws_instance.odoo.public_dns
}

output "ssh_command" {
  value = "ssh -i ${var.key_path} ubuntu@${aws_instance.odoo.public_dns}"
}

output "web_url" {
  value = "http://${aws_instance.odoo.public_dns}"
}
