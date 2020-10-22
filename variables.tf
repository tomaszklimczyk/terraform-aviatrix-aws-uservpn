variable "name" {
  description = "Custom name for VNETs, gateways, and firewalls"
  type        = string
}

variable "prefix" {
  description = "Boolean to determine if name will be prepended with avx-"
  type        = bool
  default     = true
}

variable "suffix" {
  description = "Boolean to determine if name will be appended with -spoke"
  type        = bool
  default     = true
}

variable "region" {
  description = "The Azure region to deploy this module in"
  type        = string
}

variable "cidr" {
  description = "The CIDR range to be used for the VNET"
  type        = string
}

variable "account" {
  description = "The Azure account name, as known by the Aviatrix controller"
  type        = string
}

variable "instance_size" {
  description = "Azure Instance size for the Aviatrix gateways"
  type        = string
  default     = "Standard_B1ms"
}

variable "ha_gw" {
  description = "Boolean to determine if module will be deployed in HA or single mode"
  type        = bool
  default     = true
}

variable "active_mesh" {
  description = "Enables Aviatrix active mesh"
  type        = bool
  default     = true
}

variable "transit_gw" {
  description = "Transit gateway to attach spoke to"
  type        = string
}

variable "insane_mode" {
  description = "Set to true to enable Aviatrix high performance encryption."
  type        = bool
  default     = false
}

variable "attached" {
  description = "Set to false if you don't want to attach spoke to transit."
  type        = bool
  default     = true
}

variable "security_domain" {
  description = "Provide security domain name to which spoke needs to be deployed. Transit gateway mus tbe attached and have segmentation enabled."
  type        = string
  default     = ""
}

locals {
  lower_name = replace(lower(var.name), " ", "-")
  prefix     = var.prefix ? "avx-" : ""
  suffix     = var.suffix ? "-spoke" : ""
  name       = "${local.prefix}${local.lower_name}${local.suffix}"
  subnet     = var.insane_mode ? cidrsubnet(var.cidr, 3, 6) : aviatrix_vpc.default.subnets[0].cidr
  ha_subnet  = var.insane_mode ? cidrsubnet(var.cidr, 3, 7) : aviatrix_vpc.default.subnets[0].cidr
}

variable "vpn_gw_count" {
  description = "The amount of VPN Gateways to be deployed"
  type = string
  default = 2
}

variable "vpn_cidr" {
  description = "List of subnets to be used by the VPN gateways for VPN Clients. Needs to contain enough entries for number of vpn_gw_count"
  type = list(string)
  default = ["10.255.254.0/24","10.255.255.0/24"]
}

variable "vpn_split_tunnel" {
  description = "Allows default route to internet directly. Change to false if all traffic should be tunneled."
  type = bool
  default = true
}

variable "vpn_additional_cidrs" {
  description = "CIDR's to be routed through VPN when using split tunnelling"
  type = string
  default = "10.0.0.0/8,192.168.0.0/16,172.16.0.0/12"
}

variable "vpn_search_domains" {
  description = "List of DNS Domains to search"
  type = string
  default = ""
}

variable "vpn_name_servers" {
  description = "List of DNS Servers to use"
  type = string
  default = ""
}

variable "vpn_max_vpn_conn" {
  description = "Limit of concurrent users per VPN gateway"
  type = string
  default = "100"
}

variable "vpn_user_accelerator" {
  description = "Enable AWS Global Accelerator to optimize traffic quality"
  type = bool
  default = true
}

variable "vpn_saml_enabled" {
  description = "Enable SAML authentication"
  type = bool
  default = false
}

variable "vpn_enable_vpn_nat" {
  description = "Enable source NAT on VPN Gateways"
  type = bool
  default = true
}
