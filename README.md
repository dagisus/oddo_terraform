# oddo_terraform

Provision an Odoo platform on AWS using Packer and Terraform. The project builds a versioned AMI with Odoo pre-installed, stores database credentials in AWS Secrets Manager, and wires everything together with Terraform modules.

## Features

- Packer template to build an Odoo AMI with version tags
- Launch template that always uses the latest AMI for a given Odoo version
- Aurora PostgreSQL database with credentials stored in Secrets Manager
- Optional deployment into an existing VPC
- Example `terraform.tfvars` for quick configuration

## Prerequisites

- An AWS account with permissions for EC2, RDS, IAM, VPC, Secrets Manager and AMI creation
- Packer and Terraform installed locally
- An existing SSH key pair in AWS

## Build the Odoo AMI

```bash
cd packer
packer init .
packer build -var 'odoo_version=17.0' -var 'ami_version=v1' odoo.pkr.hcl
```

The build tags the AMI with `odoo_version` and `ami_version`. Terraform will automatically pick the latest AMI matching the requested `odoo_version`.

## Deploy with Terraform

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and fill in the required values.
2. Run `terraform init` to initialize the project.
3. Run `terraform apply` to create the infrastructure.
4. Access Odoo at the `web_url` output or connect with the `ssh_command` output.

### Using an Existing VPC

Provide these values in `terraform.tfvars` to deploy into an existing network:

```hcl
existing_vpc_id          = "vpc-123456"
existing_public_subnet_id = "subnet-123456"
existing_db_subnet_ids   = ["subnet-234567", "subnet-345678"]
```

When omitted, a new VPC and subnets are created automatically.

## Cleanup

To remove all resources created by this project run:

```bash
terraform destroy
```

Ensure you retain the Terraform state file if you plan to modify or destroy resources later.
