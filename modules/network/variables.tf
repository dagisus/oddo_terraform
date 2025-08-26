variable "existing_vpc_id" {
  description = "ID of an existing VPC to use. If null, a new VPC will be created."
  type        = string
  default     = null
}

variable "existing_public_subnet_id" {
  description = "ID of an existing public subnet for the EC2 instance. Required when using an existing VPC."
  type        = string
  default     = null
}

variable "existing_db_subnet_ids" {
  description = "List of existing subnet IDs for the RDS instance. Required when using an existing VPC."
  type        = list(string)
  default     = []
}

variable "vpc_cidr" {
  description = "CIDR block for the new VPC."
  type        = string
  default     = "172.30.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
  default     = "172.30.0.0/24"
}

variable "db_subnet_cidrs" {
  description = "CIDR blocks for the database subnets."
  type        = list(string)
  default     = ["172.30.1.0/24", "172.30.2.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for the subnets."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
