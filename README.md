# oddo_terraform
### Build an Odoo platform on AWS using Terraform

This script will create a simple Odoo distributed infrastructure using AWS EC2 for the app server and RDS for the DB. it will also create roles, VPCs and networking structure to support the environment. 

Everything created by this script will default *AWS* *free* *tier* resources. This behavior can me managed by the `variables.tf` defaults of by using the `terraform.tfvars.example`  

By default the app server will provide access to port 80, 8069 and 22, is highly recommended to change this settings to comply with desired security policies.

The Database server is not publicly accessible by default and its security group will only alow access to port 5432 to the app server's security group. If you need to access the DB directly, is recomended to do so via ssh tunnel from the app server or implementing a bastion in the VPC. 

### Install and Setup

You need previously to have an active AWS account and programmatic access to an admin user for ease of use (if not posible you'll need write permisions for EC2, RDS, IAM and VPC) also you need to create a EC2 ssh key pair and have both key-pair name and local path of pem file.

Install terraform according to your platform

Clone this repository and go to the folder

Execute `terraform init` to initialize folder

Execute `terraform apply` to provision a new odoo service in AWS. during the application, terraform will prompt for all the necessary variables including AWS access credentials.

If you want to use a parameter file to avoid build prompts, create a new `terraform.tfvars` using the `terraform.tfvars.example` template, is very important to add the desired *odoo* and *postgres* version in the variables as well as the *ssh key path* and *name*; the ssh-key name and path values don't have a default setting. 

At the end, terraform will output the db endpoint, web-app server public domain and a sample string of the ssh command to the web-app server.

Is recommended to safe the terraform state file at the end of the `terraform apply` for future modifications and/or resource deletion.
