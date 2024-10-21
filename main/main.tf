module "swiggy_vpc" {
  source              = "../modules/vpc"
  cidr_block          = var.cidr_block
  project_name        = var.project_name
  project_environment = var.project_environment
  region              = var.region
  access_key          = var.access_key
  secret_key          = var.secret_key
  owner               = var.owner
  bits                = var.bits
}
module "sg" {
  source              = "../modules/sg"
  frontend_ports      = var.frontend_ports
  backend_ports       = var.backend_ports
  ssh_port            = var.ssh_port
  troubleshooting     = var.troubleshooting
  bastion_ports       = var.bastion_ports
  project_name        = var.project_name
  project_environment = var.project_environment
  swiggy_vpc_id       = module.swiggy_vpc.vpc_id
  depends_on = [
  module.swiggy_vpc.vpc_id]
}
module "key_pair" {
  source              = "../modules/key-pair"
  project_name        = var.project_name
  project_environment = var.project_environment
}
module "lt" {
  source              = "../modules/lt"
  project_name        = var.project_name
  project_environment = var.project_environment
  sg_backend_id       = module.sg.sg_backend_id
  key_pair            = module.key_pair.key_name
  ami_id_map          = var.ami_id_map
  region              = var.region
  instance_type       = var.instance_type
  owner               = var.owner
  user_data           = filebase64("setup.sh")
}
module "troubleshooting_instance" {
  count               = var.troubleshooting == true ? 1 : 0
  source              = "../modules/troubleshooting-instance"
  project_name        = var.project_name
  project_environment = var.project_environment
  sg_freedom_id       = module.sg.sg_freedom_id
  key_pair            = module.key_pair.key_name
  ami_id_map          = var.ami_id_map
  region              = var.region
  instance_type       = var.instance_type
  owner               = var.owner
  subnet_id           = module.swiggy_vpc.public1
}
module "asg" {
  source                   = "../modules/asg"
  private_subnets          = module.swiggy_vpc.private_subnet_ids
  lt_id                    = module.lt.lt_id
  project_name             = var.project_name
  project_environment      = var.project_environment
  desired_size             = var.desired_size
  min_size                 = var.min_size
  max_size                 = var.max_size
  enable_elb_health_checks = var.enable_elb_health_checks
  lt_version               = module.lt.lt_version
}
module "tg" {
  source              = "../modules/tg"
  vpc_id              = module.swiggy_vpc.vpc_id
  project_name        = var.project_name
  project_environment = var.project_environment
}
module "asg_to_tg_attachment" {
  source = "../modules/asg_to_tg_attachment"
  asg_id = module.asg.id
  tg_arn = module.tg.arn
}
module "alb" {
  source              = "../modules/alb"
  sg_id               = module.sg.sg_frontend_id
  public_subnet_ids   = module.swiggy_vpc.public_subnet_ids
  project_name        = var.project_name
  project_environment = var.project_environment
  certificate_arn     = module.acm.arn
  alb_arn             = module.alb.arn
  tg_arn              = module.tg.arn
  zone_id             = data.aws_route53_zone.main.zone_id
  domain_name         = data.aws_route53_zone.main.name
}
module "acm" {
  source      = "../modules/acm"
  domain_name = data.aws_route53_zone.main.name
  zone_id     = data.aws_route53_zone.main.zone_id
}
