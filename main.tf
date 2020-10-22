resource "aviatrix_vpc" "default" {
  cloud_type           = 8
  account_name         = var.account
  region               = var.region
  name                 = local.name
  cidr                 = var.cidr
  aviatrix_firenet_vpc = false
}

resource "aviatrix_spoke_gateway" "default" {
  cloud_type                        = 8
  account_name                      = var.account
  gw_name                           = local.name
  vpc_id                            = aviatrix_vpc.default.vpc_id
  vpc_reg                           = var.region
  gw_size                           = var.instance_size
  ha_gw_size                        = var.ha_gw ? var.instance_size : null
  subnet                            = local.subnet
  ha_subnet                         = var.ha_gw ? local.ha_subnet : null
  insane_mode                       = var.insane_mode
  enable_active_mesh                = var.active_mesh
  manage_transit_gateway_attachment = false
}

resource "aviatrix_spoke_transit_attachment" "default" {
  count           = var.attached ? 1 : 0
  spoke_gw_name   = aviatrix_spoke_gateway.default.gw_name
  transit_gw_name = var.transit_gw
}

resource "aviatrix_segmentation_security_domain_association" "default" {
  count                = var.attached ? (length(var.security_domain) > 0 ? 1 : 0) : 0 #Only create resource when attached and security_domain is set.
  transit_gateway_name = var.transit_gw
  security_domain_name = var.security_domain
  attachment_name      = aviatrix_spoke_gateway.default.gw_name
  depends_on           = [aviatrix_spoke_transit_attachment.default] #Let's make sure this cannot create a race condition
}

#Aviatrix VPN Gateway
resource "aviatrix_gateway" "vpn" {
  count = var.vpn_gw_count
  cloud_type       = 1
  account_name     = var.account
  gw_name          = "${local.name}-vpn-gw-${count.index+1}"
  vpc_id           = aviatrix_vpc.default.vpc_id
  vpc_reg          = var.region
  gw_size          = var.instance_size
  subnet           = local.subnet
  vpn_access       = true
  vpn_cidr         = var.vpn_cidr[count.index]
  split_tunnel     = var.vpn_split_tunnel
  additional_cidrs = var.vpn_additional_cidrs
  search_domains   = var.vpn_search_domains
  name_servers     = var.vpn_name_servers
  max_vpn_conn     = var.vpn_max_vpn_conn
  enable_elb       = true #Required for User Accelerator
  elb_name         = "${local.name}-elb"
  saml_enabled     = var.vpn_saml_enabled
  enable_vpn_nat   = var.vpn_enable_vpn_nat
}


