#create vpc

module "vpc" {
  source                    = "../modules/vpc"
  region                    = var.region
  project_name              = var.project_name
  cidr_block                = var.cidr_block
  public_subnet_az2         = var.public_subnet_az2
  public_subnet_az1         = var.public_subnet_az1
  private_subnet_az1        = var.private_subnet_az1
  private_subnet_az2        = var.private_subnet_az2
  private_data_subnet_az1   = var.private_data_subnet_az1
  private_data_subnet_az2   = var.private_data_subnet_az2
}

#create natgw

module "natgw" {
  source = "../modules/nat-gw"
  public_subnet_az1     = module.vpc.public_subnet_az1_id
  igw                   = module.vpc.igw
  cidr_block_id         = module.vpc.cidr_block_id
  private_subnet_az1_id = module.vpc.private_subnet_az1_id
  private_subnet_az2_id = module.vpc.private_subnet_az2_id
}
#create sg
module "security_groups" {
  source = "../modules/security-groups"
  cidr_block_ids = module.vpc.cidr_block_id
}

#create ecs

module "ecs_tasks" {
  source = "../modules/ecs-task-execution"
  project_name = module.vpc.project_name
}

#create certificate
module "acm" {
  source          = "../modules/acm"
  domain_name     = var.domain_name
  alternative_name= var.alternative_name
}

#create loadbanlancer

module "alb" {
  source = "../modules/alb"
  project_name = module.vpc.project_name
  alb_security_group_ids = module.security_groups.alb_security_group_ids
  cidr_block_id = module.vpc.cidr_block_id
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  public_subnet_az2_id = module.vpc.public_subnet_az2_id
  certificate_arn = module.acm.certificate_arn
}