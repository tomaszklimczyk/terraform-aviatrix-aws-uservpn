#Spoke VPC
resource "aviatrix_vpc" "default" {
  cloud_type           = 1
  name                 = "${var.spoke_name}-spoke-vpc"
  region               = var.region
  cidr                 = var.cidr
  account_name         = var.aws_account_name
  aviatrix_firenet_vpc = false
  aviatrix_transit_vpc = true
}

# Single Spoke GW
resource "aviatrix_spoke_gateway" "single" {
  count              = var.ha_gw ? 0 : 1
  enable_active_mesh = true
  cloud_type         = 1
  vpc_reg            = var.region
  gw_name            = "${var.spoke_name}-spoke-gw"
  gw_size            = var.spoke_gw_instance_size
  vpc_id             = aws_vpc.default.id
  account_name       = var.aws_account_name
  subnet             = aviatrix_vpc.default.subnets[0].cidr
  transit_gw         = var.transit_gw
}

# HA Spoke GW
resource "aviatrix_spoke_gateway" "ha" {
  count              = var.ha_gw ? 1 : 0
  enable_active_mesh = true
  cloud_type         = 1
  vpc_reg            = var.region
  gw_name            = "${var.spoke_name}-spoke-gw"
  gw_size            = var.spoke_gw_instance_size
  vpc_id             = aws_vpc.default.id
  account_name       = var.aws_account_name
  subnet             = aviatrix_vpc.default.subnets[0].cidr
  subnet             = aviatrix_vpc.default.subnets[1].cidr
  ha_gw_size         = var.spoke_gw_instance_size
  transit_gw         = var.transit_gw
}

#Aviatrix VPN Gateway
resource "aviatrix_gateway" "vpn" {
  count = var.vpn_gw_count
  cloud_type       = 1
  account_name     = var.aws_account_name
  gw_name          = "${var.spoke_name}-vpn-gw-${count.index+1}"
  vpc_id           = aviatrix_vpc.default.id
  vpc_reg          = var.aws_region
  gw_size          = var.vpn_gw_instance_size
  subnet           = aviatrix_vpc.default.subnets[0].cidr
  vpn_access       = true
  vpn_cidr         = var.vpn_cidr
  split_tunnel     = var.vpn_split_tunnel
  additional_cidrs = var.vpn_additional_cidrs
  search_domains   = var.vpn_search_domains
  name_servers     = var.vpn_name_servers
  max_vpn_conn     = var.vpn_max_vpn_conn
  enable_elb       = true #Required for User Accelerator
  elb_name         = var.spoke_name
  saml_enabled     = false
  #enable_vpn_nat   = false
}

# Create an Aviatrix Vpn User Accelerator
resource "aviatrix_vpn_user_accelerator" "vpc_accelerator" {
  count              = var.vpn_user_accelerator ? 1 : 0
  elb_name = aviatrix_gateway.vpn.elb_name
}