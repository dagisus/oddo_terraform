# oddo_terraform
Terraform for Odoo

you need previously to have an active AWS account and programatic access with an admin user (key and secret) also you need to create a EC2 ssh key pair and have both key-pair name and local path of pem file.

clone this repository and go to the folder

install terraform

execute `terraform init` to initialize folder

create a new `terraform.tfvars` using the `terraform.tfvars.example` template, is very important to add the desired odoo and postgres version in the variables as well as the ssh key path and name; the ssh-key name and path values don't have a default setting. 

execute `terraform apply` to provision a new odoo service in AWS 

at the end, terraform will output the db endpoint, web-app server public domain and a sample string of the ssh command to the web-app server
