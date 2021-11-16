output "vpc_id" {
  value = ibm_is_vpc.vpc.id
}

output "vpc_default_security_group_id" {
  value = ibm_is_vpc.vpc.default_security_group
}

output "vpc_zone_1_outside_subnet_id" {
  value = ibm_is_subnet.zone_1_outside.id
}

output "vpc_zone_1_outside_subnet_cidr" {
  value = ibm_is_subnet.zone_1_outside.ipv4_cidr_block
}

output "vpc_zone_1_inside_subnet_id" {
  value = ibm_is_subnet.zone_1_inside.id
}

output "vpc_zone_1_inside_subnet_cidr" {
  value = ibm_is_subnet.zone_1_inside.ipv4_cidr_block
}

output "vpc_zone_1_inside_gateway" {
  value = cidrhost(ibm_is_subnet.zone_1_inside.ipv4_cidr_block, 1)
}

output "vpc_zone_2_outside_subnet_id" {
  value = ibm_is_subnet.zone_2_outside.id
}

output "vpc_zone_2_outside_subnet_cidr" {
  value = ibm_is_subnet.zone_2_outside.ipv4_cidr_block
}

output "vpc_zone_2_inside_subnet_id" {
  value = ibm_is_subnet.zone_2_inside.id
}

output "vpc_zone_2_inside_subnet_cidr" {
  value = ibm_is_subnet.zone_2_inside.ipv4_cidr_block
}

output "vpc_zone_2_inside_gateway" {
  value = cidrhost(ibm_is_subnet.zone_2_inside.ipv4_cidr_block, 1)
}

output "vpc_zone_3_outside_subnet_id" {
  value = ibm_is_subnet.zone_3_outside.id
}

output "vpc_zone_3_outside_subnet_cidr" {
  value = ibm_is_subnet.zone_3_outside.ipv4_cidr_block
}

output "vpc_zone_3_inside_subnet_id" {
  value = ibm_is_subnet.zone_3_inside.id
}

output "vpc_zone_3_inside_subnet_cidr" {
  value = ibm_is_subnet.zone_3_inside.ipv4_cidr_block
}

output "vpc_zone_3_inside_gateway" {
  value = cidrhost(ibm_is_subnet.zone_3_inside.ipv4_cidr_block, 1)
}
