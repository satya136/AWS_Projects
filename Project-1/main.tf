module "iam" {
  source = "./modules/iam"
}

module "vpc" {
  source = "./modules/vpc"
  public_subnets_cidr = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  vpc_cidr = var.vpc_cidr
}

module "rds" {
  source = "./modules/rds"
  db_port = var.db_port
  db_engine = var.db_engine
  db_engine_version = var.db_engine_version
  db_instance = var.db_instance
  db_instance_identifier = var.db_instance_identifier
  db_name = var.db_name
  db_storage = var.db_storage
  db_storage_type = var.db_storage_type
  username = var.username
  private_subnet_ids = module.vpc.private_subnets
  vpc_cidr = module.vpc.vpc_cidr
  vpc_id = module.vpc.vpc_id
}