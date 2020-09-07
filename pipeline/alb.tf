module "appLb" {
  source = "./modules/network"

  create_security_group = true
  tags                  = local.tags
  vpc_id                = module.vpc.vpc_id[0]
}

module "appLbRules" {
  source = "./modules/network"

  sg_rules = {
    "egress_rule" = {
      "type"              = "egress"
      "from_port"         = 0
      "to_port"           = 65535
      "protocol"          = "tcp"
      "cidr_blocks"       = ["0.0.0.0/0"]
      "security_group_id" = module.appLb.security_group_id[0]
    }
    "https_rule" = {
      "type"              = "ingress"
      "from_port"         = 80
      "to_port"           = 80
      "protocol"          = "tcp"
      "cidr_blocks"       = ["0.0.0.0/0"]
      "security_group_id" = module.appLb.security_group_id[0]
    }
  }
}

module "alb" {
  source = "./modules/lb/"

  name = var.app_name

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id[0]
  subnets         = [module.public_subnet_1b.subnet_id[0], module.public_subnet_1a.subnet_id[0]]
  security_groups = module.appLb.security_group_id

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]


  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Test"
  }
}
