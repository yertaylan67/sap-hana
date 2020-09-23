output prefix {
  value = tomap({ "SDU" = local.sdu_name, "DEPLOYER" = local.deployer_name, "VNET" = local.vnet_name, "LIBRARY" = local.library_name })
}

output storageaccount_names {
  value = tomap({ "SDU" = [local.sdu_sa_name], "DEPLOYER" = [local.deployer_sa_name], "VNET" = [local.vnet_sa_name], "LIBRARY" = [local.library_sa_name,local.state_sa_name] })
}

output resource_extensions {
  value = var.resource_extension
}

output virtualmachine_names {
  value = tomap({ "ANYDB" = local.anydb_server_names,  "ANYDB_HA" = local.anydb_server_names_ha, "APP" = local.app_server_names, "DEPLOYER" = local.deployer_names, "HANA" = local.hana_server_names, "HANA_HA" = local.hana_server_names_ha, "SCS" = local.scs_server_names, "WEB" = local.web_server_names,  "ISCSI" = local.iscsi_server_names  })
}

output keyvault_names {
  value = tomap({ "SDU" = local.sdu_kvname, "DEPLOYER" = local.deployer_kvname, "VNET" = local.vnet_kvname, "LIBRARY" = local.library_kvname })
}
