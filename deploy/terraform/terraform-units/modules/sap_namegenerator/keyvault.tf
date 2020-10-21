locals {

  sdu_privileged_keyvault_name      = format("%s%s%s%sp%s", local.env_verified, local.location_short, local.vnet_verified, var.sap_sid, local.random_id_verified)
  sdu_user_keyvault_name            = format("%s%s%s%su%s", local.env_verified, local.location_short, local.vnet_verified, var.sap_sid, local.random_id_verified)

  deployer_privileged_keyvault_name = format("%s%s%sprvt%s", local.env_verified, local.location_short, local.dep_vnet_verified, local.random_id_verified)
  deployer_user_keyvault_name       = format("%s%s%suser%s", local.env_verified, local.location_short, local.dep_vnet_verified, local.random_id_verified)

  vnet_privileged_keyvault_name     = format("%s%s%sprvt%s", local.env_verified, local.location_short, local.vnet_verified, local.random_id_verified)
  vnet_user_keyvault_name           = format("%s%s%suser%s", local.env_verified, local.location_short, local.vnet_verified, local.random_id_verified)

  library_privileged_keyvault_name  = format("%s%sSAPLIBprvt%s", local.env_verified, local.location_short, local.random_id_verified)
  library_user_keyvault_name        = format("%s%sSAPLIBuser%s", local.env_verified, local.location_short, local.random_id_verified)

}
