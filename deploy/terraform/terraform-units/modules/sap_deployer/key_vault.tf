// Create private KV with access policy
data "azurerm_client_config" "deployer" {}

resource "azurerm_key_vault" "kv_prvt" {
  count                      = (local.enable_deployers && ! local.prvt_kv_exist) ? 1 : 0
<<<<<<< HEAD
  name                       = local.prvt_kv_name
=======
  name                       = local.keyvault_names.private_access
>>>>>>> import existing key vaults to sap deployer
  location                   = azurerm_resource_group.deployer[0].location
  resource_group_name        = azurerm_resource_group.deployer[0].name
  tenant_id                  = data.azurerm_client_config.deployer.tenant_id
  soft_delete_enabled        = true
  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  sku_name = "standard"
}

// Import an existing private Key Vault
data "azurerm_key_vault" "kv_prvt" {
  count               = (local.enable_deployers && local.prvt_kv_exist) ? 1 : 0
  name                = local.prvt_kv_name
  resource_group_name = local.prvt_kv_rg_name
}

resource "azurerm_key_vault_access_policy" "kv_prvt_msi" {
  count        = (local.enable_deployers && ! local.prvt_kv_exist) ? 1 : 0
  key_vault_id = azurerm_key_vault.kv_prvt[0].id

  tenant_id = data.azurerm_client_config.deployer.tenant_id
  object_id = azurerm_user_assigned_identity.deployer.principal_id

  secret_permissions = [
    "get",
  ]
}

// Create user KV with access policy
resource "azurerm_key_vault" "kv_user" {
  count                      = (local.enable_deployers && ! local.user_kv_exist) ? 1 : 0
<<<<<<< HEAD
  name                       = local.user_kv_name
=======
  name                       = local.keyvault_names.user_access
>>>>>>> import existing key vaults to sap deployer
  location                   = azurerm_resource_group.deployer[0].location
  resource_group_name        = azurerm_resource_group.deployer[0].name
  tenant_id                  = data.azurerm_client_config.deployer.tenant_id
  soft_delete_enabled        = true
  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  sku_name = "standard"
}

// Import an existing user Key Vault
data "azurerm_key_vault" "kv_user" {
  count               = (local.enable_deployers && local.user_kv_exist) ? 1 : 0
  name                = local.user_kv_name
  resource_group_name = local.user_kv_rg_name
}

resource "azurerm_key_vault_access_policy" "kv_user_msi" {
  count        = (local.enable_deployers && ! local.user_kv_exist) ? 1 : 0
  key_vault_id = azurerm_key_vault.kv_user[0].id

  tenant_id = data.azurerm_client_config.deployer.tenant_id
  object_id = azurerm_user_assigned_identity.deployer.principal_id

  secret_permissions = [
    "delete",
    "get",
    "list",
    "set",
  ]
}

resource "azurerm_key_vault_access_policy" "kv_user_pre_deployer" {
  count        = (local.enable_deployers && ! local.user_kv_exist) ? 1 : 0
  key_vault_id = azurerm_key_vault.kv_user[0].id

  tenant_id = data.azurerm_client_config.deployer.tenant_id
  object_id = data.azurerm_client_config.deployer.object_id != "" ? data.azurerm_client_config.deployer.object_id : "00000000-0000-0000-0000-000000000000"

  secret_permissions = [
    "delete",
    "get",
    "list",
    "set",
  ]

  lifecycle {
    ignore_changes = [
      // Ignore changes to object_id
      object_id,
    ]
  }
}

// Comment out code with users.object_id for the time being.
/*
resource "azurerm_key_vault_access_policy" "kv_user_portal" {
  count        = local.enable_deployers ? length(local.deployer_users_id_list) : 0
  key_vault_id = azurerm_key_vault.kv_user[0].id

  tenant_id = data.azurerm_client_config.deployer.tenant_id
  object_id = local.deployer_users_id_list[count.index]

  secret_permissions = [
    "delete",
    "get",
    "list",
    "set",
  ]
}
*/

// Using TF tls to generate SSH key pair and store in user KV
resource "tls_private_key" "deployer" {
  count = (
    local.enable_deployers
    && local.enable_key
    && ! local.user_kv_exist
    && (try(file(var.sshkey.path_to_public_key), "") == "" ? true : false)
  ) ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 2048
}

/*
 To force dependency between kv access policy and secrets. Expected behavior:
 https://github.com/terraform-providers/terraform-provider-azurerm/issues/4971
*/

resource "azurerm_key_vault_secret" "ppk" {
  depends_on   = [azurerm_key_vault_access_policy.kv_user_pre_deployer[0]]
  count        = (local.enable_deployers && local.enable_key && ! local.user_kv_exist) ? 1 : 0
<<<<<<< HEAD
  name         = local.ppk_name
=======
  name         = format("%s-sshkey", local.prefix)
>>>>>>> import existing key vaults to sap deployer
  value        = local.private_key
  key_vault_id = azurerm_key_vault.kv_user[0].id
}

resource "azurerm_key_vault_secret" "pk" {
  depends_on   = [azurerm_key_vault_access_policy.kv_user_pre_deployer[0]]
  count        = (local.enable_deployers && local.enable_key && ! local.user_kv_exist) ? 1 : 0
<<<<<<< HEAD
  name         = local.pk_name
=======
  name         = format("%s-sshkey-pub", local.prefix)
>>>>>>> import existing key vaults to sap deployer
  value        = local.public_key
  key_vault_id = azurerm_key_vault.kv_user[0].id
}

// Generate random password if password is set as authentication type, and save in KV
resource "random_password" "deployer" {
  count = (
    local.enable_deployers
    && local.enable_password
    && ! local.user_kv_exist
    && local.input_pwd == null ? true : false
  ) ? 1 : 0
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_key_vault_secret" "pwd" {
  depends_on   = [azurerm_key_vault_access_policy.kv_user_pre_deployer[0]]
  count        = (local.enable_deployers && local.enable_password && ! local.user_kv_exist) ? 1 : 0
<<<<<<< HEAD
  name         = local.pwd_name
=======
  name         = format("%s-password", local.prefix)
>>>>>>> import existing key vaults to sap deployer
  value        = local.password
  key_vault_id = azurerm_key_vault.kv_user[0].id
}

data "azurerm_key_vault_secret" "pk" {
  count        = (local.enable_deployers && local.enable_key && local.user_kv_exist) ? 1 : 0
<<<<<<< HEAD
  name         = local.pk_name
=======
  name         = format("%s-sshkey-pub", local.prefix)
>>>>>>> import existing key vaults to sap deployer
  key_vault_id = local.user_key_vault_id
}

data "azurerm_key_vault_secret" "ppk" {
  count        = (local.enable_deployers && local.enable_key && local.user_kv_exist) ? 1 : 0
<<<<<<< HEAD
  name         = local.ppk_name
=======
  name         = format("%s-sshkey", local.prefix)
>>>>>>> import existing key vaults to sap deployer
  key_vault_id = local.user_key_vault_id
}

data "azurerm_key_vault_secret" "pwd" {
  count        = (local.enable_deployers && local.enable_password && local.user_kv_exist) ? 1 : 0
<<<<<<< HEAD
  name         = local.pwd_name
=======
  name         = format("%s-password", local.prefix)
>>>>>>> import existing key vaults to sap deployer
  key_vault_id = local.user_key_vault_id
}
