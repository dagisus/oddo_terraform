locals {
  use_existing_vpc = var.existing_vpc_id != null
}

resource "aws_vpc" "this" {
  count               = local.use_existing_vpc ? 0 : 1
  cidr_block          = var.vpc_cidr
  enable_dns_support  = true
  enable_dns_hostnames = true
}

data "aws_vpc" "this" {
  count = local.use_existing_vpc ? 1 : 0
  id    = var.existing_vpc_id
}

locals {
  vpc_id = local.use_existing_vpc ? data.aws_vpc.this[0].id : aws_vpc.this[0].id
}

resource "aws_subnet" "public" {
  count             = local.use_existing_vpc ? 0 : 1
  vpc_id            = local.vpc_id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zones[0]
}

data "aws_subnet" "public" {
  count = local.use_existing_vpc ? 1 : 0
  id    = var.existing_public_subnet_id
}

locals {
  public_subnet_id = local.use_existing_vpc ? data.aws_subnet.public[0].id : aws_subnet.public[0].id
}

resource "aws_subnet" "db" {
  count             = local.use_existing_vpc ? 0 : length(var.db_subnet_cidrs)
  vpc_id            = local.vpc_id
  cidr_block        = var.db_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
}

data "aws_subnet" "db" {
  count = local.use_existing_vpc ? length(var.existing_db_subnet_ids) : 0
  id    = var.existing_db_subnet_ids[count.index]
}

locals {
  db_subnet_ids = local.use_existing_vpc ? data.aws_subnet.db[*].id : aws_subnet.db[*].id
}

resource "aws_db_subnet_group" "this" {
  name       = "main_bd_subnet_group"
  subnet_ids = local.db_subnet_ids
}

resource "aws_internet_gateway" "igw" {
  count  = local.use_existing_vpc ? 0 : 1
  vpc_id = local.vpc_id

  tags = {
    Name = "main"
  }
}

data "aws_route_table" "selected" {
  count  = local.use_existing_vpc ? 0 : 1
  vpc_id = local.vpc_id
}

resource "aws_route" "default" {
  count                  = local.use_existing_vpc ? 0 : 1
  route_table_id         = data.aws_route_table.selected[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id
}

resource "aws_security_group" "app" {
  name        = "odooSG_terra"
  description = "Security group for Odoo server"
  vpc_id      = local.vpc_id

  ingress {
    from_port   = 8069
    to_port     = 8069
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db" {
  name        = "odooDBSG_terra"
  description = "Security group for Odoo database"
  vpc_id      = local.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
