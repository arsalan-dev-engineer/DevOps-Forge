
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
}

