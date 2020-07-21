output "vpc" {
  value = aviatrix_vpc.default
}

output "spoke_gateway" {
  value = var.ha_gw ? aviatrix_spoke_gateway.ha[0] : aviatrix_spoke_gateway.single[0]
}

output "vpn_gateway" {
  value = aviatrix_gateway.vpn
}