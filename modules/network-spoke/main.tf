resource "azurerm_virtual_network" "spoke" {
  name = var.vnet_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = var.address_space
}

# Spoke to Hub
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name = "peer-${var.vnet_name}-to-hub"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = var.hub_vnet_id
}

# Hub to Spoke
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name = "peer-hub-to-${var.vnet_name}"

  # This peering lives in the HUB's rg
  resource_group_name = split("/", var.hub_vnet_id)[4]
  virtual_network_name = var.hub_vnet_name
  remote_virtual_network_id = azurerm_virtual_network.spoke.id
}