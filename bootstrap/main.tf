terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "tfstate_rg" {
  name     = "rg-${var.project_prefix}-tfstate"
  location = var.location
}

# Random string for storage name
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

# Storage Account
resource "azurerm_storage_account" "tfstate_sa" {
  name                     = "st${var.project_prefix}tfstate${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.tfstate_rg.name
  location                 = azurerm_resource_group.tfstate_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Blob Container for state file
resource "azurerm_storage_container" "tfstate_container" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate_sa.id
  container_access_type = "private"
}