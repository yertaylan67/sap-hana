output prefixes {
  value = tomap({ "SDU" = local.sdu_name, "DEPLOYER" = local.deployer_name, "VNET" = local.vnet_name, "LIBRARY" = local.library_name })
}

output sa_name {
  value = tomap({ "SDU" = [local.sdu_sa_name], "DEPLOYER" = [local.deployer_sa_name], "VNET" = [local.vnet_sa_name], "LIBRARY" = [local.library_sa_name,local.state_sa_name] })
}

output resource_extensions {
  value = var.resource-extension
}

output vm_names {
  value = tomap({ "ANYDB" = local.anydb_server_names, "APP" = local.app_server_names, "DEPLOYER" = local.deployer_names, "HANA" = local.hana_server_names, "SCS" = local.scs_server_names, "WEB" = local.scs_server_names })
}

output kv_names {
  value = tomap({ "SDU" = local.sdu_kvname, "DEPLOYER" = local.deployer_kvname, "VNET" = local.vnet_kvname, "LIBRARY" = local.library_kvname })
}

output db_server_max_count {
  value = var.db_server_max_count
}
