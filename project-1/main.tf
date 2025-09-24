
module "network" {
  source = "./network/"
}


module "application" {
  source = "./application"
  vpc_id = module.network.vpc_id
  private_subnet_id_A = module.network.private_subnet_id_A
  private_subnet_id_B = module.network.private_subnet_id_B
  alb_id   = module.network.alb_id
  alb_sg_id = module.network.alb_sg_id

  db_endpoint= module.database.db_endpoint
  db_name= module.database.db_name
}



module "database" {
  source = "./data"

 db_subnet_group = module.network.db_subnet_group
 instance_sg = module.application.instance_sg
 vpc_id = module.network.vpc_id
 db_password = var.db_password

 }

