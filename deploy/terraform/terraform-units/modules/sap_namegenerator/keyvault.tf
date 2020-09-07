locals {

  sdu_kvname      = [format("%s%s%s%sp%s", upper(local.env_verified), upper(local.location_short), upper(local.vnet_verified), upper(var.sap_sid),upper(substr(var.random-id,0,4))),
    format("%s%s%s%su%s", upper(local.env_verified), upper(local.location_short), upper(local.vnet_verified), upper(var.sap_sid),upper(substr(var.random-id,0,4)))]
  deployer_kvname = [format("%s%s%sprvt%s", upper(local.env_verified), upper(local.location_short), upper(local.dep_vnet_verified), upper(substr(var.random-id,0,4))),
    format("%s%s%suser%s", upper(local.env_verified), upper(local.location_short), upper(local.dep_vnet_verified), upper(substr(var.random-id,0,4)))]
  vnet_kvname     = [format("%s%s%sprvt%s", upper(local.env_verified), upper(local.location_short), upper(local.vnet_verified), upper(substr(var.random-id,0,4))),
    format("%s%s%suser%s", upper(local.env_verified), upper(local.location_short), upper(local.vnet_verified), upper(substr(var.random-id,0,4)))]
  library_kvname  = [format("%s%sSAPLIBprvt%s",upper(local.env_verified), upper(local.location_short), upper(substr(var.random-id,0,4))),
    format("%s%sSAPLIBuser%s",upper(local.env_verified), upper(local.location_short), upper(substr(var.random-id,0,4)))]

}
