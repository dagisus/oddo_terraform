variable "access_key" {
  description = "AWS IAM user access key ID"
  type        = string
}

variable "secret_key" {
  description = "AWS IAM user access key secret"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "dbuser" {
  description = "Database user name"
  type        = string
}

variable "dbpassword" {
  description = "Database user password"
  type        = string
}

variable "db_engine_version" {
  description = "Aurora PostgreSQL engine version"
  type        = string
  default     = "15.3"
}

variable "ssh_key" {
  description = "AWS EC2 SSH key name"
  type        = string
}

variable "ssh_key_path" {
  description = "Absolute path to the SSH private key file"
  type        = string
}

variable "odoo_version" {
  description = "Odoo version to install"
  type        = string
  default     = "17.0"
}

variable "rds_instance_type" {
  description = "RDS DB instance type"
  type        = string
  default     = "db.t4g.medium"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t4g.medium"
}

variable "existing_vpc_id" {
  description = "Optional existing VPC ID to use"
  type        = string
  default     = null
}

variable "existing_public_subnet_id" {
  description = "Optional existing public subnet ID for the EC2 instance"
  type        = string
  default     = null
}

variable "existing_db_subnet_ids" {
  description = "Optional existing subnet IDs for the RDS instance"
  type        = list(string)
  default     = []
}

variable "vpc_cidr" {
  description = "CIDR block for the new VPC"
  type        = string
  default     = "172.30.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "172.30.0.0/24"
}

variable "db_subnet_cidrs" {
  description = "CIDR blocks for the database subnets"
  type        = list(string)
  default     = ["172.30.1.0/24", "172.30.2.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
