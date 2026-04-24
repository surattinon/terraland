output "app_subnet_id" {
  description = "The ID of the Vendor App Subnet"
  value = azurerm_subnet.app_subnet.id
}