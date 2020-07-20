# terraform-aviatrix-aws-uservpn

### Description
This module deploys a VPC, Aviatrix spoke gateways and one or more Aviatrix UserVPN gateways behind an elastic loadbalancer. To be used in conjunction with Aviatrix transit.

### Diagram
\<Provide a diagram of the high level constructs thet will be created by this module>
<img src="<IMG URL>"  height="250">

### Usage Example
```
module "vpn_1" {
  source  = "terraform-aviatrix-modules/aws-uservpn/aviatrix"
  version = "1.0.0"

  cidr = "10.1.0.0/20"
  region = "eu-west-1"
  aws_account_name = "AWS"
}
```

### Variables
The following variables are required:

key | value
:--- | :---
spoke_name | Name for the VPN spoke
region | AWS region to deploy the transit VPC in
cidr | The IP CIDR wo be used to create the VPC
aws_account_name | The AWS accountname on the Aviatrix controller, under which the controller will deploy this VPC
transit_gw | The name of the Aviatrix Transit gateway to attach the spoke

The following variables are optional:

key | default | value 
:---|:---|:---
spoke_gw_instance_size | "t3.medium" |
vpn_gw_instance_size | "t3.medium" |
ha_gw | true |
vpn_gw_count | 2 |
vpn_cidr | "10.255.255.0/24" |
vpn_split_tunnel | true |
vpn_additional_cidrs | "10.0.0.0/8,192.168.0.0/16,172.16.0.0/12" |
vpn_search_domains | "" |
vpn_name_servers | "" |
vpn_max_vpn_conn | "100" |
vpn_user_accelerator | true |
vpn_saml_enabled | false |
vpn_enable_vpn_nat | true |

### Outputs
This module will return the following outputs:

key | description
:---|:---
vpc | 
spoke_gateway | 