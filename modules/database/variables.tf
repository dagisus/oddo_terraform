variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}

variable "engine_version" {
  description = "Aurora PostgreSQL engine version"
  type        = string
}

variable "instance_type" {
  description = "RDS instance class"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones for cluster instances"
  type        = list(string)
}

variable "db_subnet_group_name" {
  description = "DB subnet group name"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Security groups for the RDS cluster"
  type        = list(string)
}
