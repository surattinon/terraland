output "vnet_id" {
  description = "The ID of the VNet Hub"
  value = azurerm_virtual_network.hub.id
}

output "vnet_name" {
  description = "The Name of the VNet Hub"
  value = azurerm_virtual_network.hub.name
}