output "vpc_id" {
  value = module.ibm_vpc.vpc_id
  description = "ADC VPC identifier"
}

output "zone_1_inside_subnet_id" {
  value = module.ibm_vpc.vpc_zone_1_inside_subnet_id
  description = "ADC VPC Zone 1 inside subnet indentifier"
}

output "zone_1_inside_subnet_cidr" {
  value = module.ibm_vpc.vpc_zone_1_inside_subnet_cidr
  description = "ADC inside Zone 1 IPv4 CIDR"
}

output "zone_1_outside_subnet_id" {
  value = module.ibm_vpc.vpc_zone_1_outside_subnet_id
  description = "ADC VPC Zone 1 outside subnet indentifier"
}

output "zone_1_outside_subnet_cidr" {
  value = module.ibm_vpc.vpc_zone_1_outside_subnet_cidr
  description = "ADC outside Zone 1 IPv4 CIDR"
}

output "zone_2_inside_subnet_id" {
  value = module.ibm_vpc.vpc_zone_2_inside_subnet_id
  description = "ADC VPC Zone 2 inside subnet indentifier"
}

output "zone_2_inside_subnet_cidr" {
  value = module.ibm_vpc.vpc_zone_2_inside_subnet_cidr
  description = "ADC inside Zone 2 IPv4 CIDR"
}

output "zone_2_outside_subnet_id" {
  value = module.ibm_vpc.vpc_zone_2_outside_subnet_id
  description = "ADC VPC Zone 2 outside subnet indentifier"
}

output "zone_2_outside_subnet_cidr" {
  value = module.ibm_vpc.vpc_zone_2_outside_subnet_cidr
  description = "ADC outside Zone 2 IPv4 CIDR"
}

output "zone_3_inside_subnet_id" {
  value = module.ibm_vpc.vpc_zone_3_inside_subnet_id
  description = "ADC VPC Zone 3 inside subnet indentifier"
}

output "zone_3_inside_subnet_cidr" {
  value = module.ibm_vpc.vpc_zone_3_inside_subnet_cidr
  description = "ADC inside Zone 3 IPv4 CIDR"
}

output "zone_3_outside_subnet_id" {
  value = module.ibm_vpc.vpc_zone_3_outside_subnet_id
  description = "ADC VPC Zone 3 outside subnet indentifier"
}

output "zone_3_outside_subnet_cidr" {
  value = module.ibm_vpc.vpc_zone_3_outside_subnet_cidr
  description = "ADC outside Zone 3 IPv4 CIDR"
}

output "consul_datacenter" {
  value = join("", module.consul_cluster_vsis.*.datacenter)
  description = "ADC tier Consul datacenter"
}

output "consul_datacenter_ca_certificate" {
  value = join("", module.consul_cluster_vsis.*.datacenter_ca_certificate)
  description = "ADC tier Consul datacenter CA certificate"
}

output "consul_client_token" {
  value = join("", module.consul_cluster_vsis.*.client_token)
  description = "ADC tier Consul client ACL token with right to register nodes and service"
}

output "consul_https_endpoints" {
  value = join("", module.consul_cluster_vsis.*.https_endpoints)
  description = "ADC tier Consul HTTPs endpoints"
}

output "consul_dns_endpoints" {
  value = join("", module.consul_cluster_vsis.*.dns_endpoints)
  description = "ADC tier Consul DNS endpoints"
}

output "consul_ca_p12" {
  value = join("", module.consul_cluster_vsis.*.ca_p12)
  description = "ADC tier Consul CA PKCS12 bundle to sign outside certificate requests"
}

output "consul_encrypt" {
  value = join("", module.consul_cluster_vsis.*.encrypt)
  description = "ADC tier Consul RPC encryption secret"
}

output "voltconsole_endpoint" {
  value = join("", module.volterra_cluster.*.voltconsole_endpoint)
  description = "ADC tier Volterra Volt Console endpoint"
}