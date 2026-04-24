variable "location" { type = string }

variable "resource_group_name" { type = string }

variable "vnet_config" {
  description = "Configuration object for the Hub VNet"
  type = object({
    name          = string
    address_space = list(string)
  })
}

variable "subnets" {
  description = "A map subnets to create inside the Hub VNet"
  type = map(object({
    address_prefixes = list(string)
  }))
}