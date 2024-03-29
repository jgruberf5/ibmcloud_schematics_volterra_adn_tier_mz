# Volterra ADN Routing Tier in IBM VPC Gen2

![Workspace Diagram](https://github.com/jgruberf5/ibmcloud_schematics_volterra_adn_tier_mz/raw/master/assets/ibmcloud_schematices_adn_adc_tier_diagram.jpg)

This Schematics Workspace module lifecycle manages:

- IBM VPC Gen2 VPC
- IBM VPC Subnets within the created VPC for all 3 availablity zones
- Consul Cluster VSIs per availablity zone (optional)
- Volterra CE VSI per availablity zone (optional)
- Volterra Site
- Volterra Fleet
- Volterra Network Connector to the global shared/public network
- Volterra Virtual Network exporting routes to IBM Transit Gateway networks
- Votlerra Discovery for Consul VSIs

The application of this Workspace module results in the necessary Volterra system namespace resources required to connect workloads routable via IBM Transit Gateways to the Volterra ADN. The output includes the CA certificate and the Consul client access token to register services with the Consul cluster which in-turn becomes available by service name to the Volterra ADN.

## Variables values

You will have to define the following variables:

| Key | Definition | Required/Optional | Default Value |
| --- | ---------- | ----------------- | ------------- |
| `ibm_resource_group` | The resource group to create the VPC and VSIs | optional | default |
| `ibm_region` | The IBM Cloud region to create the VPC | optional | us-south |
| `ibm_vpc_name` | VPC name, will also be the Volterra site name prefix | required |  |
| `ibm_vpc_index` | Index number allowing for mulitple VPC in the same zone  | required | 1 |
| `ibm_vpc_cidr` | The VPC prefix CIDR | required | |
| `ibm_ssh_key_name` | The name of the IBM stored SSH key to inject into VSIs | required |  |
| `ibm_transit_gateway_id` | The optional IBM transit gateway to connect the VPC | optional | |
| `ibm_internal_networks` | List of HCL object defining IPv4 CIDRs (cidr attribute) and IPv4 gateway (gw attribute) to connect via the CE VSIs | optional | [] |
| `volterra_include_ce` | Create Volterra CE VSIs and Volterra ADN objects | optional | true |
| `volterra_ce_profile` | The VSI profile to use for Volterra CE instances | optional | cx2-4x8 |
| `volterra_ce_version` | The Volterra version to download from the F5 COS catalog | optional | 7.2009.5 |
| `volterra_tenant_name` | The Volterra tenant (group) name | required | |
| `volterra_api_token` | The Volterra API token used to manage Volterra resources | required | |
| `volterra_ce_per_zone` | The number of Volterra CE instances per availablity zone | optional | 1 |
| `volterra_admin_password` | The admin user password for the CE instances | optional | randomized string |
| `volterra_ssl_tunnels` | Allow SSL tunnels to connect the Volterra CE to the RE | optional | false |
| `volterra_ipsec_tunnels` | Allow IPSEC tunnels to connect the Volterra CE to the RE | optional | true |
| `consul_include` | Create a Consul cluster for service discovery | optional | true |
| `consul_instance_profile` | The VSI profile to use for Consul instances | optional | cx2-4x8 |
| `consul_client_token` | The UUID value to use for the Consul client ACL token | optional | auto generate |

## Creating Volterra CE Site in an Existing VPC

You can utilize the Volterra module in the `modules/volterra` to deploy Volterra CE sites in existing IBM VPC Gen2 VPCs.

Simply change the github workspace repository reference to:

```bash
https://github.com/jgruberf5/ibmcloud_schematics_volterra_adn_tier_mz/modules/volterra
```
