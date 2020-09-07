output "vpc_arn" {
  value = aws_vpc.vpc.*.arn
}

output "vpc_id" {
  value = aws_vpc.vpc.*.id
}

output "subnet_arn" {
  value = aws_subnet.subnet.*.arn
}

output "subnet_id" {
  value = aws_subnet.subnet.*.id
}

output "security_group_arn" {
  value = aws_security_group.security_group.*.arn
}

output "security_group_id" {
  value = aws_security_group.security_group.*.id
}

output "ngw_id" {
  value = aws_nat_gateway.ngw.*.id
}

output "eip_id" {
  value = aws_eip.eip.*.id
}

output "igw_id" {
  value = aws_internet_gateway.gw.*.id
}

output "egw_id" {
  value = aws_egress_only_internet_gateway.egw.*.id
}

output "rt_id" {
  value = aws_route_table.rt.*.id
}
