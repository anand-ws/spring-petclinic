provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "vpc" {
  count = var.create_vpc ? 1 : 0

  cidr_block = var.vpc_cidr_block
  tags       = var.tags
}

resource "aws_subnet" "subnet" {

  count = var.create_subnet ? 1 : 0

  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone

  tags = var.tags
}

resource "aws_internet_gateway" "gw" {

  count = var.create_internet_gateway ? 1 : 0

  vpc_id = var.vpc_id
  tags   = var.tags
}

resource "aws_egress_only_internet_gateway" "egw" {
  count = var.create_egress_only_igw ? 1 : 0

  vpc_id = var.vpc_id
  tags   = var.tags
}


resource "aws_security_group" "security_group" {
  count  = var.create_security_group ? 1 : 0
  vpc_id = var.vpc_id
  tags   = var.tags
}

resource "aws_security_group_rule" "security_group_rule" {

  for_each = var.sg_rules

  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  security_group_id = each.value.security_group_id
  description       = each.key
}

resource "aws_nat_gateway" "ngw" {
  count = var.create_nat_gateway ? 1 : 0

  allocation_id = var.gw_allocation_id
  subnet_id     = var.nat_subnet_id
  tags          = var.tags
}

resource "aws_eip" "eip" {
  count = var.create_eip ? 1 : 0

  instance = var.eip_instance_id
  vpc      = true
  tags     = var.tags
}



# -----------------------------------

resource "aws_route_table" "rt" {
  count = var.create_route_table ? 1 : 0

  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.route
    content {
      cidr_block = lookup(route.value, "cidr_block")
      gateway_id = lookup(route.value, "gateway_id")
    }
  }
  tags = var.tags
}

resource "aws_route_table_association" "rt_association" {
  count          = var.create_rt_association ? 1 : 0
  subnet_id      = var.subnet_id
  route_table_id = var.route_table_id
}


resource "aws_route" "route" {
  count = var.create_route ? 1 : 0

  route_table_id         = var.route_table_id
  destination_cidr_block = var.destination_cidr_block
  nat_gateway_id         = var.nat_gateway_id
}
