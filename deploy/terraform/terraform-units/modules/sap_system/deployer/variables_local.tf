variable library_prefix {
  type        = string
  description = "SAP Library resource naming prefix"
}

variable resource_suffixes {
  type        = map
  description = "List of resource suffixes"
}

// Imports from tfstate
locals {
  // Get deployer remote tfstate info
  deployer_config = try(var.infrastructure.vnets.management, {})

  // Default value follows naming convention
  saplib_resource_group_name   = try(local.deployer_config.saplib_resource_group_name, format("%s%s", var.library_prefix, var.resource_suffixes["library-rg"]))
  tfstate_storage_account_name = try(local.deployer_config.tfstate_storage_account_name, "")
  tfstate_container_name       = "tfstate"
  deployer_tfstate_key         = try(local.deployer_config.deployer_tfstate_key, format("%s%s", var.library_prefix, var.resource_suffixes["deployer-state"]))
}
