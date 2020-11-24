
locals {
  // Sap library's environment
  environment = upper(try(var.infrastructure.environment, ""))

  // Derive resource group name for deployer
  deployer                = try(var.deployer, {})
  deployer_environment    = try(local.deployer.environment, "")
  deployer_vnet           = try(local.deployer.vnet, "")
  deployer_prefix         = module.naming.prefix.DELOYER
  // If custom names are used for deployer, providing resource_group_name and msi_name will override the naming convention
  deployer_rg_name = try(local.deployer.resource_group_name, format("%s%s", local.deployer_prefix,module.resource_suffixes.naming.deployer_rg))

  // Retrieve the arm_id of deployer's Key Vault from deployer's terraform.tfstate
  deployer_key_vault_arm_id = try(data.terraform_remote_state.deployer.outputs.deployer_kv_user_arm_id, "")

  spn = {
    subscription_id = data.azurerm_key_vault_secret.subscription_id.value,
    client_id       = data.azurerm_key_vault_secret.client_id.value,
    client_secret   = data.azurerm_key_vault_secret.client_secret.value,
    tenant_id       = data.azurerm_key_vault_secret.tenant_id.value,
  }

  service_principal = {
    subscription_id = local.spn.subscription_id,
    client_id       = local.spn.client_id,
    client_secret   = local.spn.client_secret,
    tenant_id       = local.spn.tenant_id,
    object_id       = data.azuread_service_principal.sp.id
  }

}
