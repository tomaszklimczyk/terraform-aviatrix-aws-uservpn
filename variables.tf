variable "spoke_name" {
  type = string
}

variable "region" {
  type = string
}

variable "cidr" {
  type = string
}

variable "aws_account_name" {
  type = string
}

variable "transit_gw" {
  type = string
}

variable "spoke_gw_instance_size" {
  type    = string
  default = "t3.medium"
}

variable "vpn_gw_instance_size" {
  type    = string
  default = "t3.medium"
}

variable "ha_gw" {
  type    = bool
  default = true
}

variable "vpn_gw_count" {
  type = string
  default = 2
}

variable "vpn_cidr" {
  type = string
  default = "10.255.255.0/24"
}

variable "vpn_split_tunnel" {
  type = bool
  default = true
}

variable "vpn_additional_cidrs" {
  type = string
  default = "10.0.0.0/8,192.168.0.0/16,172.16.0.0/12"
}

variable "vpn_search_domains" {
  type = string
  default = ""
}

variable "vpn_name_servers" {
  type = string
  default = ""
}

variable "vpn_max_vpn_conn" {
  type = string
  default = "100"
}

variable "vpn_user_accelerator" {
  type = bool
  default = true
}

variable "vpn_saml_enabled" {
  type = bool
  default = false
}

variable "vpn_enable_vpn_nat" {
  type = bool
  default = true
}

variable "subnet_length" {
  type = map
  default = {
    "1"   = "0"
    "2"   = "1"
    "3"   = "2"
    "4"   = "2"
    "5"   = "3"
    "6"   = "3"
    "7"   = "3"
    "8"   = "3"
    "9"   = "4"
    "10"   = "4"
    "11"   = "4"
    "12"   = "4"
    "13"   = "4"
    "14"   = "4"
    "15"   = "4"
    "16"   = "4"
  }
}