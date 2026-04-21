output "tfstate_storage_name" {
  description = "Output for storage account name"
  value = azurerm_storage_account.tfstate_sa.name
}