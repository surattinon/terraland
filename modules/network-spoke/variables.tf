variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "vnet_name" { type = string }
variable "address_space" { type = list(string) }

# Bridge Variables
variable "hub_vnet_id" {
  description = "The ID of the VNet Hub for peering"
  type = string
}

variable "hub_vnet_name" {
  description = "The name of the VNet Hub for peering"
  type = string
}