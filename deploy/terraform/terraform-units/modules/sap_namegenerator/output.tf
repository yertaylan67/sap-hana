output naming {
  value = {
    prefix = {
      DEPLOYER = local.deployer_name,
      SDU = local.sdu_name,
      VNET = local.vnet_name, 
      LIBRARY = local.library_name
    }
    storageaccount_names = {
      DEPLOYER = [local.deployer_sa_name],
      SDU = [local.sdu_sa_name],
      VNET = [local.vnet_sa_name], 
      LIBRARY = [local.library_sa_name,local.state_sa_name]
    }
    resource_suffixes = var.resource_suffixes
    virtualmachine_names = {
      ANYDB = local.anydb_server_names
      ANYDB_HA = local.anydb_server_names_ha
      APP = local.app_server_names,
      DEPLOYER = local.deployer_vm_names,
      HANA = local.hana_server_names
      HANA_HA = local.hana_server_names_ha,
      ISCSI = local.iscsi_server_names 
      SCS = local.scs_server_names,
      WEB = local.web_server_names,  
    }
    keyvault_names = {
      DEPLOYER = local.deployer_keyvault_name,
      LIBRARY = local.library_keyvault_name 
      SDU = local.sdu_keyvault_name, 
      VNET = local.vnet_keyvault_name
    }
  }
}
