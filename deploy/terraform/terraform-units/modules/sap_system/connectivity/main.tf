# VNET PEERINGs ==================================================================================================

# Peers management VNET to SAP VNET
resource "azurerm_virtual_network_peering" "peering-management-sap" {
  name                         = substr("${var.vnet-mgmt.resource_group_name}_${var.vnet-mgmt.name}-${var.vnet-sap.resource_group_name}_${var.vnet-sap.name}", 0, 80)
  resource_group_name          = var.vnet-mgmt.resource_group_name
  virtual_network_name         = var.vnet-mgmt.name
  remote_virtual_network_id    = var.vnet-sap.id
  allow_virtual_network_access = true
  provider = azurerm.deployer
}

# Peers SAP VNET to management VNET
resource "azurerm_virtual_network_peering" "peering-sap-management" {
  name                         = substr("${var.vnet-sap.resource_group_name}_${var.vnet-sap.name}-${var.vnet-mgmt.resource_group_name}_${var.vnet-mgmt.name}", 0, 80)
  resource_group_name          = var.vnet-sap.resource_group_name
  virtual_network_name         = var.vnet-mgmt.name
  remote_virtual_network_id    = var.vnet-mgmt.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  provider = azurerm.saplandscape
}

provider "azurerm" {
  alias  = "deployer"
  features {}
}

provider "azurerm" {
  alias  = "saplandscape"
  features {}
}
