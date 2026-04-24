resource "azurerm_virtual_network" "spoke" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

# Spoke to Hub
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "peer-${var.vnet_name}-to-hub"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = var.hub_vnet_id
}

# Hub to Spoke
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name = "peer-hub-to-${var.vnet_name}"

  # This peering lives in the HUB's rg
  resource_group_name       = split("/", var.hub_vnet_id)[4]
  virtual_network_name      = var.hub_vnet_name
  remote_virtual_network_id = azurerm_virtual_network.spoke.id
}

# Vendor Subnet
resource "azurerm_subnet" "app_subnet" {
  name                 = "snet-vendor-app-001"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = ["10.0.1.0/26"]
}

# NSG 
resource "azurerm_network_security_group" "app_nsg" {
  name                = "nsg-vender-app-001"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Rules
  security_rule {
    name                       = "Allow-HTTPS-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Deny-SSH-Internet"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

# Subnet NSG Assosiation
resource "azurerm_subnet_network_security_group_association" "app_nsg_link" {
  subnet_id                 = azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}