locals {
  volterra_ce_per_zone = var.volterra_include_ce ? var.volterra_ce_per_zone : 0
}

module "ibm_vpc" {
  source                 = "./modules/ibm_vpc"
  ibm_region             = var.ibm_region
  ibm_resource_group     = var.ibm_resource_group
  ibm_transit_gateway_id = var.ibm_transit_gateway_id
  ibm_ssh_key_name       = var.ibm_ssh_key_name
  ibm_vpc_name           = var.ibm_vpc_name
  ibm_vpc_cidr           = var.ibm_vpc_cidr
  ibm_vpc_index          = var.ibm_vpc_index
}

module "consul_cluster_vsis" {
  source                = "./modules/consul_vsis"
  ibm_resource_group    = var.ibm_resource_group
  ibm_region            = var.ibm_region
  ibm_profile           = var.consul_instance_profile
  ibm_ssh_key_name      = var.ibm_ssh_key_name
  ibm_security_group_id = module.ibm_vpc.vpc_default_security_group_id
  ibm_zone_1_subnet_id  = module.ibm_vpc.vpc_zone_1_inside_subnet_id
  ibm_zone_2_subnet_id  = module.ibm_vpc.vpc_zone_2_inside_subnet_id
  ibm_zone_3_subnet_id  = module.ibm_vpc.vpc_zone_3_inside_subnet_id
  consul_include        = var.consul_include
  consul_organization   = var.volterra_tenant_name
  consul_datacenter     = "${var.ibm_vpc_name}-${var.ibm_region}-${var.ibm_vpc_index}"
  consul_client_token   = var.consul_client_token
}

module "volterra_cluster" {
  source                        = "./modules/volterra"
  volterra_ce_per_zone          = local.volterra_ce_per_zone
  ibm_resource_group            = var.ibm_resource_group
  ibm_region                    = var.ibm_region
  ibm_profile                   = var.volterra_ce_profile
  ibm_ssh_key_name              = var.ibm_ssh_key_name
  ibm_zone_1_outside_subnet_id  = module.ibm_vpc.vpc_zone_1_outside_subnet_id
  ibm_zone_1_inside_subnet_id   = module.ibm_vpc.vpc_zone_1_inside_subnet_id
  ibm_zone_2_outside_subnet_id  = module.ibm_vpc.vpc_zone_2_outside_subnet_id
  ibm_zone_2_inside_subnet_id   = module.ibm_vpc.vpc_zone_2_inside_subnet_id
  ibm_zone_3_outside_subnet_id  = module.ibm_vpc.vpc_zone_3_outside_subnet_id
  ibm_zone_3_inside_subnet_id   = module.ibm_vpc.vpc_zone_3_inside_subnet_id
  ibm_outside_security_group_id = module.ibm_vpc.vpc_default_security_group_id
  ibm_inside_security_group_id  = module.ibm_vpc.vpc_default_security_group_id
  ibm_zone_1_inside_gateway     = module.ibm_vpc.vpc_zone_1_inside_gateway
  ibm_zone_2_inside_gateway     = module.ibm_vpc.vpc_zone_2_inside_gateway
  ibm_zone_3_inside_gateway     = module.ibm_vpc.vpc_zone_3_inside_gateway
  ibm_inside_networks           = var.ibm_internal_networks
  volterra_ce_version           = var.volterra_ce_version
  volterra_tenant_name          = var.volterra_tenant_name
  volterra_site_name            = "${var.ibm_vpc_name}-${var.ibm_region}-${var.ibm_vpc_index}"
  volterra_fleet_label          = "${var.ibm_vpc_name}-${var.ibm_region}-${var.ibm_vpc_index}-fleet"
  volterra_api_token            = var.volterra_api_token
  volterra_admin_password       = var.volterra_admin_password
  volterra_ipsec_tunnels        = var.volterra_ipsec_tunnels
  volterra_ssl_tunnels          = var.volterra_ssl_tunnels
  consul_ca_cert                = join("", module.consul_cluster_vsis.*.datacenter_ca_certificate)
  consul_https_servers          = join("", module.consul_cluster_vsis.*.https_endpoints) == "" ? [] : jsondecode(join("", module.consul_cluster_vsis.*.https_endpoints))
}
