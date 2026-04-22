variable "location" {
  description = "The AZ Region for sandbox environment."
  default = "eastasia"
}

# Resource Group
resource "azurerm_resource_group" "sandbox_rg" {
  name = "rg-terraland-sandbox"
  location = var.location
}

# Network Hub Module
module "hub_network" {
  source = "../../modules/network-hub"

  location = azurerm_resource_group.sandbox_rg.location
  resource_group_name = azurerm_resource_group.sandbox_rg.name

  vnet_config = {
    name = "vnet-hub-sandbox-001"
    address_space = ["10.0.0.0/24"]
  }

  subnets = {
    "AzureFirewallSubnet" = {
        address_prefixes = ["10.0.0.0/26"] # 10.0.0.0 - 10.0.0.63
    }
    "AzureBastionSubnet" = {
        address_prefixes = ["10.0.0.64/26"] # 10.0.0.64 - 10.0.0.127
    }
    "GatewaySubnet" = {
        address_prefixes = ["10.0.0.128/27"] # 10.0.0.128 - 10.0.0.159
    }
  }
}
