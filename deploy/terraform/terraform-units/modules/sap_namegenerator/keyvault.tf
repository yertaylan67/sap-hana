locals {

  sdu_kvname      = [format("%s%s%s%sp%s", local.env_verified, local.location_short, local.vnet_verified, var.sap_sid,substr(var.random-id,0,4)),format("%s%s%s%su%s", local.env_verified, local.location_short, local.vnet_verified, var.sap_sid,substr(var.random-id,0,4))]
  deployer_kvname = [format("%s%s%sprvt%s", local.env_verified, local.location_short, local.dep_vnet_verified, substr(var.random-id,0,4)),format("%s%s%suser%s", local.env_verified, local.location_short, local.dep_vnet_verified, substr(var.random-id,0,4))]
  vnet_kvname     = [lower(format("%s%s%sprvt%s", local.env_verified, local.location_short, local.vnet_verified, substr(var.random-id,0,4))),lower(format("%s%s%suser%s", local.env_verified, local.location_short, local.vnet_verified, substr(var.random-id,0,4)))]
  library_kvname  = [format("%s%sSAPLIBprvt%s",local.env_verified, local.location_short, substr(var.random-id,0,4)),format("%s%sSAPLIBuser%s",local.env_verified, local.location_short, substr(var.random-id,0,4))]

}
