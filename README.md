# oddo11_terraform
Terraform for Odoo 11

you need previously to have an active AWS account and programatic access with an admin user (key and secret) also you need to create a EC2 ssh key pair and have both key-pair name and local path of pem file.

install terraform

execute `terraform init` to initialize folder

create a new `terraform.tfvars` using the `terraform.tfvars.example` template

execute `terraform apply` to provision a new odoo 11 service in AWS
