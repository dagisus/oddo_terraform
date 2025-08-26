variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the instance"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs for the instance"
  type        = list(string)
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "key_path" {
  description = "Path to the SSH private key"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "db_secret_arn" {
  description = "ARN of the database credentials secret"
  type        = string
}

variable "odoo_version" {
  description = "Odoo version for AMI lookup"
  type        = string
}
