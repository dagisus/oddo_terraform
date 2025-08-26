module "iam" {
  source = "./modules/iam"
}

module "network" {
  source                   = "./modules/network"
  existing_vpc_id          = var.existing_vpc_id
  existing_public_subnet_id = var.existing_public_subnet_id
  existing_db_subnet_ids   = var.existing_db_subnet_ids
  vpc_cidr                 = var.vpc_cidr
  public_subnet_cidr       = var.public_subnet_cidr
  db_subnet_cidrs          = var.db_subnet_cidrs
  availability_zones       = var.availability_zones
}

module "database" {
  source                = "./modules/database"
  db_username           = var.dbuser
  db_password           = var.dbpassword
  engine_version        = var.db_engine_version
  instance_type         = var.rds_instance_type
  availability_zones    = var.availability_zones
  db_subnet_group_name  = module.network.db_subnet_group_name
  vpc_security_group_ids = [module.network.db_security_group_id]
}

module "compute" {
  source               = "./modules/compute"
  instance_type        = var.ec2_instance_type
  iam_instance_profile = module.iam.instance_profile_name
  subnet_id            = module.network.public_subnet_id
  security_group_ids   = [module.network.app_security_group_id]
  key_name             = var.ssh_key
  key_path             = var.ssh_key_path
  region               = var.region
  db_secret_arn        = module.database.db_secret_arn
  odoo_version         = var.odoo_version
}
