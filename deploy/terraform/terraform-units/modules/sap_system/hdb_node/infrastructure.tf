// AVAILABILITY SET
resource "azurerm_availability_set" "hdb" {
  count = local.enable_deployment ? max(length(local.zones), 1) : 0
  name = local.zonal_deployment ? (
    format("%s%sz%s%s%s", local.prefix, var.naming.separator, local.zones[count.index], var.naming.separator, local.resource_suffixes.db_avset)) : (
    format("%s%s%s", local.prefix, var.naming.separator, local.resource_suffixes.db_avset)
  )
  location                     = var.resource_group[0].location
  resource_group_name          = var.resource_group[0].name
  platform_update_domain_count = 20
  platform_fault_domain_count  = 2
  proximity_placement_group_id = local.zonal_deployment ? var.ppg[count.index % length(local.zones)].id : var.ppg[0].id
  managed                      = true
}

// Scaleout on ANF

resource "azurerm_subnet" "scaleout" {
  count                = local.enable_deployment &&  local.scaleout_subnet_needed ? (local.sub_scaleout_exists ? 0 : 1) : 0
  name                 = local.sub_scaleout_name
  resource_group_name  = local.vnet_sap_resource_group_name
  virtual_network_name = local.vnet_sap_name
  address_prefixes     = [local.sub_scaleout_prefix]
}

// Imports data of existing db subnet
data "azurerm_subnet" "scaleout" {
  count                = local.enable_deployment && local.scaleout_subnet_needed  ? (local.sub_scaleout_exists ? 1 : 0) : 0
  name                 = split("/", local.sub_scaleout_arm_id)[10]
  resource_group_name  = split("/", local.sub_scaleout_arm_id)[4]
  virtual_network_name = split("/", local.sub_scaleout_arm_id)[8]
}
