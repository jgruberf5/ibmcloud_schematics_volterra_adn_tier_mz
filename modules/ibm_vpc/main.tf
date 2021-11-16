locals {
  ibm_traffic_gateway_connection_count = var.ibm_transit_gateway_id == "" ? 0 : 1
  zone_1_prefix                        = cidrsubnet(var.ibm_vpc_cidr, 2, 0)
  zone_2_prefix                        = cidrsubnet(var.ibm_vpc_cidr, 2, 1)
  zone_3_prefix                        = cidrsubnet(var.ibm_vpc_cidr, 2, 2)
}

resource "ibm_is_vpc" "vpc" {
  name                      = "${var.ibm_vpc_name}-${var.ibm_region}-${var.ibm_vpc_index}"
  resource_group            = data.ibm_resource_group.group.id
  address_prefix_management = "manual"
}

resource "ibm_is_vpc_address_prefix" "zone_1_vpc_address_prefix" {
  name = "${var.ibm_vpc_name}-${var.ibm_region}-1-${var.ibm_vpc_index}-ap"
  zone = "${var.ibm_region}-1"
  vpc  = ibm_is_vpc.vpc.id
  cidr = local.zone_1_prefix
}

resource "ibm_is_vpc_address_prefix" "zone_2_vpc_address_prefix" {
  name = "${var.ibm_vpc_name}-${var.ibm_region}-2-${var.ibm_vpc_index}-ap"
  zone = "${var.ibm_region}-2"
  vpc  = ibm_is_vpc.vpc.id
  cidr = local.zone_2_prefix
}

resource "ibm_is_vpc_address_prefix" "zone_3_vpc_address_prefix" {
  name = "${var.ibm_vpc_name}-${var.ibm_region}-3-${var.ibm_vpc_index}-ap"
  zone = "${var.ibm_region}-3"
  vpc  = ibm_is_vpc.vpc.id
  cidr = local.zone_3_prefix
}

// allow all inbound
resource "ibm_is_security_group_rule" "allow_inbound" {
  depends_on = [ibm_is_vpc.vpc]
  group      = ibm_is_vpc.vpc.default_security_group
  direction  = "inbound"
  remote     = "0.0.0.0/0"
}

// all all outbound
resource "ibm_is_security_group_rule" "allow_outbound" {
  depends_on = [ibm_is_vpc.vpc]
  group      = ibm_is_vpc.vpc.default_security_group
  direction  = "outbound"
  remote     = "0.0.0.0/0"
}

resource "ibm_is_subnet" "zone_1_inside" {
  name            = "${var.ibm_vpc_name}-${var.ibm_region}-1-inside"
  vpc             = ibm_is_vpc.vpc.id
  zone            = "${var.ibm_region}-1"
  resource_group  = data.ibm_resource_group.group.id
  depends_on      = [ibm_is_vpc_address_prefix.zone_1_vpc_address_prefix]
  ipv4_cidr_block = cidrsubnet(local.zone_1_prefix, 2, 1)
}

resource "ibm_is_public_gateway" "zone_1_outside_gateway" {
  name = "${var.ibm_vpc_name}-1-outside-gateway"
  vpc  = ibm_is_vpc.vpc.id
  zone = "${var.ibm_region}-1"
}

resource "ibm_is_subnet" "zone_1_outside" {
  name            = "${var.ibm_vpc_name}-${var.ibm_region}-1-outside"
  vpc             = ibm_is_vpc.vpc.id
  zone            = "${var.ibm_region}-1"
  resource_group  = data.ibm_resource_group.group.id
  depends_on      = [ibm_is_vpc_address_prefix.zone_1_vpc_address_prefix]
  ipv4_cidr_block = cidrsubnet(local.zone_1_prefix, 2, 0)
  public_gateway  = ibm_is_public_gateway.zone_1_outside_gateway.id
}

resource "ibm_is_subnet" "zone_2_inside" {
  name            = "${var.ibm_vpc_name}-${var.ibm_region}-2-inside"
  vpc             = ibm_is_vpc.vpc.id
  zone            = "${var.ibm_region}-2"
  resource_group  = data.ibm_resource_group.group.id
  depends_on      = [ibm_is_vpc_address_prefix.zone_2_vpc_address_prefix]
  ipv4_cidr_block = cidrsubnet(local.zone_2_prefix, 2, 1)
}

resource "ibm_is_public_gateway" "zone_2_outside_gateway" {
  name = "${var.ibm_vpc_name}-2-outside-gateway"
  vpc  = ibm_is_vpc.vpc.id
  zone = "${var.ibm_region}-2"
}

resource "ibm_is_subnet" "zone_2_outside" {
  name            = "${var.ibm_vpc_name}-${var.ibm_region}-2-outside"
  vpc             = ibm_is_vpc.vpc.id
  zone            = "${var.ibm_region}-2"
  resource_group  = data.ibm_resource_group.group.id
  depends_on      = [ibm_is_vpc_address_prefix.zone_2_vpc_address_prefix]
  ipv4_cidr_block = cidrsubnet(local.zone_2_prefix, 2, 0)
  public_gateway  = ibm_is_public_gateway.zone_2_outside_gateway.id
}

resource "ibm_is_subnet" "zone_3_inside" {
  name            = "${var.ibm_vpc_name}-${var.ibm_region}-3-inside"
  vpc             = ibm_is_vpc.vpc.id
  zone            = "${var.ibm_region}-3"
  resource_group  = data.ibm_resource_group.group.id
  depends_on      = [ibm_is_vpc_address_prefix.zone_3_vpc_address_prefix]
  ipv4_cidr_block = cidrsubnet(local.zone_3_prefix, 2, 1)
}

resource "ibm_is_public_gateway" "zone_3_outside_gateway" {
  name = "${var.ibm_vpc_name}-3-outside-gateway"
  vpc  = ibm_is_vpc.vpc.id
  zone = "${var.ibm_region}-3"
}

resource "ibm_is_subnet" "zone_3_outside" {
  name            = "${var.ibm_vpc_name}-${var.ibm_region}-3-outside"
  vpc             = ibm_is_vpc.vpc.id
  zone            = "${var.ibm_region}-3"
  resource_group  = data.ibm_resource_group.group.id
  depends_on      = [ibm_is_vpc_address_prefix.zone_3_vpc_address_prefix]
  ipv4_cidr_block = cidrsubnet(local.zone_3_prefix, 2, 0)
  public_gateway  = ibm_is_public_gateway.zone_3_outside_gateway.id
}

data "ibm_is_ssh_key" "ssh_key" {
  name = var.ibm_ssh_key_name
}

resource "ibm_tg_connection" "ibm_tg_connect" {
  count        = local.ibm_traffic_gateway_connection_count
  gateway      = var.ibm_transit_gateway_id
  network_type = "vpc"
  name         = "${var.ibm_vpc_name}-${var.ibm_region}-${var.ibm_vpc_index}-connection"
  network_id   = ibm_is_vpc.vpc.resource_crn
  depends_on   = [ibm_is_security_group_rule.allow_outbound, ibm_is_public_gateway.zone_1_outside_gateway, ibm_is_public_gateway.zone_2_outside_gateway, ibm_is_public_gateway.zone_3_outside_gateway]
}
