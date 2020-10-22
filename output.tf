output "vnet" {
  description = "The created net as an object with all of it's attributes. This was created using the aviatrix_vpc resource."
  value       = aviatrix_vpc.default
}

output "spoke_gateway" {
  description = "The created Aviatrix spoke gateway as an object with all of it's attributes."
  value       = aviatrix_spoke_gateway.default
}

output "vpn_gateway" {
  description = "A list of the created Aviatrix VPN gateways as an object with all of it's attributes."
  value = aviatrix_gateway.vpn
}
