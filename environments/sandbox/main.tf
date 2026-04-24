variable "location" {
  description = "The AZ Region for sandbox environment."
  default     = "southeastasia"
}
variable "location_short" { default = "sea" }

# Resource Group
resource "azurerm_resource_group" "sandbox_rg" {
  name     = "rg-terraland-${var.location_short}-sandbox"
  location = var.location
}

# Network Hub Module
module "hub_network" {
  source = "../../modules/network-hub"

  location            = azurerm_resource_group.sandbox_rg.location
  resource_group_name = azurerm_resource_group.sandbox_rg.name

  vnet_config = {
    name          = "vnet-hub-sandbox-${var.location_short}-001"
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

  depends_on = [ azurerm_resource_group.sandbox_rg ]
}

# Vendor Network Spoke Module
module "vendor_spoke" {
  source = "../../modules/network-spoke"

  location            = azurerm_resource_group.sandbox_rg.location
  resource_group_name = azurerm_resource_group.sandbox_rg.name

  vnet_name     = "vnet-spoke-vendor-${var.location_short}-001"
  address_space = ["10.0.1.0/24"]

  hub_vnet_id   = module.hub_network.vnet_id
  hub_vnet_name = module.hub_network.vnet_name

  depends_on = [ module.hub_network ]
}

# Policy: FinOps
module "finops_policy" {
  source            = "../../modules/governance-finops"
  resource_group_id = azurerm_resource_group.sandbox_rg.id
  allowed_vm_skus = [
    "Standard_B1s",
    "Standard_B2ats_v2",
    "Standard_B2pts_v2"
  ]
  depends_on = [ azurerm_resource_group.sandbox_rg ]
}
