module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = "10.2.0.0/16"
  availability_zones = ["ap-southeast-2a", "ap-southeast-2b"]
  public_subnets     = ["10.2.1.0/24", "10.2.2.0/24"]        # Публічні підмережі
  private_subnets    = ["10.2.3.0/24", "10.2.4.0/24"]        # Приватні підмережі
  vpc_name           = "vpc"
}


module "s3_backend" {
  source      = "./modules/s3-backend"                    # Шлях до модуля
  bucket_name = "terraform-state-bucket-18062025214500" # Ім'я S3-бакета
}

module "rds" {
  source                = "./modules/rds"
  db_name               = var.db_name
  db_user               = var.db_user
  db_password           = var.db_password
  db_subnet_group_name  = var.db_subnet_group_name
  private_subnets       = module.vpc.private_subnets
}