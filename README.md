# terraform-aviatrix-aws-uservpn

### Description
This module deploys a VPC, Aviatrix spoke gateways and one or more Aviatrix UserVPN gateways behind an elastic loadbalancer. To be used in conjunction with Aviatrix transit.

### Diagram
<img src="https://dhagens-repository-images-public.s3.eu-central-1.amazonaws.com/terraform-aviatrix-aws-uservpn/module-aviatrix-aws-uservpn.png.png">

### Usage Example
```
module "vpn_1" {
  source  = "terraform-aviatrix-modules/aws-uservpn/aviatrix"
  version = "1.0.0"

  spoke_name = "vpn1"
  cidr = "10.10.0.0/20"
  region = "eu-central-1"
  aws_account_name = "AWS"
  transit_gw = "transit_gateway_name"
}
```

### Variables
The following variables are required:

key | value
:--- | :---
spoke_name | Name for the VPN spoke
region | AWS region to deploy the transit VPC in
cidr | The IP CIDR to be used to create the VPC
aws_account_name | The AWS accountname on the Aviatrix controller, under which the controller will deploy this VPC
transit_gw | The name of the Aviatrix Transit gateway to attach the spoke

The following variables are optional:

key | default | value 
:---|:---|:---
spoke_gw_instance_size | "t3.medium" | Size of the spoke gateway instances
vpn_gw_instance_size | "t3.medium" | Size of the VPN gateway instances
ha_gw | true | Set to false te deploy a single transit GW.
vpn_gw_count | 2 | The amount of VPN Gateways to be deployed.
vpn_cidr | ["10.255.254.0/24", "10.255.255.0/24"] | List of subnets to be used by the VPN gateways for VPN Clients. Needs to contain enough entries for number of vpn_gw_count
vpn_split_tunnel | true | Allows default route to internet directly. Change to false if all traffic should be tunneled.
vpn_additional_cidrs | "10.0.0.0/8,192.168.0.0/16,172.16.0.0/12" | CIDR's to be routed through VPN when using split tunnelling
vpn_search_domains | | List of DNS Domains to search
vpn_name_servers | | List of DNS Servers to use
vpn_max_vpn_conn | 100 | Limit of concurrent users per VPN gateway
vpn_user_accelerator | true | Enable AWS Global Accelerator to optimize traffic quality
vpn_saml_enabled | false | Enable SAML authentication
vpn_enable_vpn_nat | true | Enable source NAT on VPN Gateways

### Outputs
This module will return the following outputs:

key | description
:---|:---
vpc | The created VPC as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
spoke_gateway | The created Aviatrix spoke gateway as an object with all of it's attributes.
vpn_gateway | A list of the created Aviatrix VPN gateways as an object with all of it's attributes.
