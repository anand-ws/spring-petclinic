module "vpc" {
  source = "./modules/network"

  create_vpc     = true
  vpc_cidr_block = var.vpc_cidr_block
  tags           = local.tags
}


module "igw" {
  source = "./modules/network"

  create_internet_gateway = true
  tags                    = local.tags
  vpc_id                  = module.vpc.vpc_id[0]
}


module "egw" {
  source = "./modules/network"
}

module "public_subnet_1a" {
  source = "./modules/network"

  create_subnet     = true
  tags              = merge(local.tags, { "Name" = "${var.app_name}-public-1a" })
  vpc_id            = module.vpc.vpc_id[0]
  subnet_cidr       = "10.0.1.0/24"
  availability_zone = "${var.region}a"
}

module "public_subnet_1b" {
  source = "./modules/network"

  create_subnet     = true
  tags              = merge(local.tags, { "Name" = "${var.app_name}-public-1b" })
  vpc_id            = module.vpc.vpc_id[0]
  subnet_cidr       = "10.0.0.0/24"
  availability_zone = "${var.region}b"
}


module "private_subnet_1a" {
  source = "./modules/network"

  create_subnet     = true
  tags              = merge(local.tags, { "Name" = "${var.app_name}-private-1a" })
  vpc_id            = module.vpc.vpc_id[0]
  subnet_cidr       = "10.0.2.0/24"
  availability_zone = "${var.region}a"
}

module "private_subnet_1b" {
  source = "./modules/network"

  create_subnet     = true
  tags              = merge(local.tags, { "Name" = "${var.app_name}-private-1b" })
  vpc_id            = module.vpc.vpc_id[0]
  subnet_cidr       = "10.0.3.0/24"
  availability_zone = "${var.region}b"

}

module "nat_eip" {
  source = "./modules/network"

  create_eip = true
  tags       = merge(local.tags, { "Name" = "${var.app_name}-nat" })
}

module "ngw" {
  source = "./modules/network"

  create_nat_gateway = true
  tags               = local.tags
  gw_allocation_id   = module.nat_eip.eip_id[0]
  nat_subnet_id      = module.public_subnet_1a.subnet_id[0]
}


module "jenkinsSG" {
  source = "./modules/network"

  create_security_group = true
  tags                  = local.tags
  vpc_id                = module.vpc.vpc_id[0]
}

module "jenkinsSgRules" {
  source = "./modules/network"

  sg_rules = {
    "egress_rule" = {
      "type"              = "egress"
      "from_port"         = 0
      "to_port"           = 65535
      "protocol"          = "tcp"
      "cidr_blocks"       = ["0.0.0.0/0"]
      "security_group_id" = module.jenkinsSG.security_group_id[0]
    }
    "https_rule" = {
      "type"              = "ingress"
      "from_port"         = 80
      "to_port"           = 443
      "protocol"          = "tcp"
      "cidr_blocks"       = ["0.0.0.0/0"]
      "security_group_id" = module.jenkinsSG.security_group_id[0]
    }
    "ssh_rule" = {
      "type"              = "ingress"
      "from_port"         = 22
      "to_port"           = 22
      "protocol"          = "tcp"
      "cidr_blocks"       = ["0.0.0.0/0"]
      "security_group_id" = module.jenkinsSG.security_group_id[0]
    }
  }
}


module "public_route_table" {
  source = "./modules/network"

  create_route_table = true
  tags               = merge(local.tags, { "Name" = "${var.app_name}-public-rt" })
  vpc_id             = module.vpc.vpc_id[0]
  route = [{
    cidr_block = "0.0.0.0/0"
    gateway_id = module.igw.igw_id[0]
  }]
}

module "public_rt_association" {
  source = "./modules/network"

  create_rt_association = true

  subnet_id      = module.public_subnet_1a.subnet_id[0]
  route_table_id = module.public_route_table.rt_id[0]
}

module "public_rt_association_1b" {
  source = "./modules/network"

  create_rt_association = true

  subnet_id      = module.public_subnet_1b.subnet_id[0]
  route_table_id = module.public_route_table.rt_id[0]
}


module "private_route_table" {
  source = "./modules/network"

  create_route_table = true
  tags               = merge(local.tags, { "Name" = "${var.app_name}-private-rt" })
  vpc_id             = module.vpc.vpc_id[0]
  route = [{
    cidr_block = "0.0.0.0/0"
    gateway_id = module.ngw.ngw_id[0]
  }]
}

module "private_rt_association_1a" {
  source = "./modules/network"

  create_rt_association = true

  subnet_id      = module.private_subnet_1a.subnet_id[0]
  route_table_id = module.private_route_table.rt_id[0]
}

module "private_rt_association_1b" {
  source = "./modules/network"

  create_rt_association = true

  subnet_id      = module.private_subnet_1b.subnet_id[0]
  route_table_id = module.private_route_table.rt_id[0]
}
