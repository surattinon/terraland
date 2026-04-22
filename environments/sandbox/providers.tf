terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # This is the connection to your new digital safe!
  backend "azurerm" {
    resource_group_name  = "rg-terraland-tfstate"
    storage_account_name = "stterralandtfstatepp7u0" 
    container_name       = "tfstate"
    key                  = "sandbox.terraform.tfstate" # The name of the file it will save
  }
}

provider "azurerm" {
  features {}
}