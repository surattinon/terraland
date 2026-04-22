resource "azurerm_virtual_network" "hub" {
  name = var.vnet_config.name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = var.vnet_config.address_space
}

resource "azurerm_subnet" "hub_subnets" {
  for_each = var.subnets

  name = each.key
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes = each.value.address_prefixes
}