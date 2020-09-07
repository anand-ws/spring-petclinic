module "appSG" {
  source = "./modules/network"

  create_security_group = true
  tags                  = local.tags
  vpc_id                = module.vpc.vpc_id[0]
}

module "appSgRules" {
  source = "./modules/network"

  sg_rules = {
    "egress_rule" = {
      "type"              = "egress"
      "from_port"         = 0
      "to_port"           = 65535
      "protocol"          = "tcp"
      "cidr_blocks"       = ["0.0.0.0/0"]
      "security_group_id" = module.appSG.security_group_id[0]
    }

    "https_rule" = {
      "type"              = "ingress"
      "from_port"         = 80
      "to_port"           = 443
      "protocol"          = "tcp"
      "cidr_blocks"       = ["0.0.0.0/0"]
      "security_group_id" = module.appSG.security_group_id[0]
    }

    "ssh_rule" = {
      "type"              = "ingress"
      "from_port"         = 22
      "to_port"           = 22
      "protocol"          = "tcp"
      "cidr_blocks"       = ["0.0.0.0/0"]
      "security_group_id" = module.appSG.security_group_id[0]
    }
  }
}


module "petclinic-app" {
  source = "./modules/autoscaling/"

  name = var.app_name

  # Launch configuration
  lc_name = "${var.app_name}-lc"

  image_id          = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"
  security_groups   = module.appSG.security_group_id
  key_name          = "anand-apac"
  target_group_arns = module.alb.target_group_arns
  user_data         = file("./utils/ins_docker.sh")

  root_block_device = [
    {
      volume_size = "8"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "${var.app_name}-asg"
  vpc_zone_identifier       = [module.private_subnet_1a.subnet_id[0], module.private_subnet_1b.subnet_id[0]]
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "EE-assignment"
      propagate_at_launch = true
    },
  ]

  tags_as_map = local.tags

}
