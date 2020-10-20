// Input arguments 
variable naming {
  description = "Defines the names for the resources"
}

// Imports from tfstate
locals {

  resource_suffixes    = var.naming.resource_suffixes
  // Get deployer remote tfstate info
  deployer_config = try(var.infrastructure.vnets.management, {})

  // Get info required for naming convention
  environment    = lower(try(var.infrastructure.environment, ""))
  region         = lower(try(var.infrastructure.region, ""))

  // Locate the tfstate storage account
  tfstate_resource_id          = try(local.deployer_config.tfstate_resource_id, "")
  saplib_subscription_id       = split("/", local.tfstate_resource_id)[2]
  saplib_resource_group_name   = split("/", local.tfstate_resource_id)[4]
  tfstate_storage_account_name = split("/", local.tfstate_resource_id)[8]
  tfstate_container_name       = "tfstate"
  deployer_tfstate_key         = try(local.deployer_config.deployer_tfstate_key, format("%s%s", var.naming.prefix.DEPLOYER, local.resource_suffixes.deployer-state))
}
