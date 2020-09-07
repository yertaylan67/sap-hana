data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "prvt" {
  name                        = format("%s%s",var.kv_names[0], var.resource_suffixes["kv"])
  location                    = azurerm_resource_group.resource-group[0].location
  resource_group_name         = azurerm_resource_group.resource-group[0].name
  enabled_for_disk_encryption = true
  enabled_for_deployment      = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get",
    ]

    secret_permissions = [
      "get",
    ]

    storage_permissions = [
      "get",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

}

resource "azurerm_key_vault" "user" {
  name                        = format("%s%s",var.kv_names[1], var.resource_suffixes["kv"])
  location                    = azurerm_resource_group.resource-group[0].location
  resource_group_name         = azurerm_resource_group.resource-group[0].name
  enabled_for_disk_encryption = true
  enabled_for_deployment      = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get",
    ]

    secret_permissions = [
      "get",
    ]

    storage_permissions = [
      "get",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

}