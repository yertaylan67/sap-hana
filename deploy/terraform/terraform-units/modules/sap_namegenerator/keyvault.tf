locals {

  sdu_kvname      = [format("%s%s%s%sp%s", local.env_verified, local.location_short, local.vnet_verified, var.sap_sid),local.random-id_verified),
    format("%s%s%s%su%s", local.env_verified, local.location_short, local.vnet_verified, var.sap_sid),local.random-id_verified)]
  deployer_kvname = [format("%s%s%sprvt%s", local.env_verified, local.location_short, local.dep_vnet_verified, local.random-id_verified),
    format("%s%s%suser%s", local.env_verified, local.location_short, local.dep_vnet_verified, local.random-id_verified)]
  vnet_kvname     = [format("%s%s%sprvt%s", local.env_verified, local.location_short, local.vnet_verified, local.random-id_verified),
    format("%s%s%suser%s", local.env_verified, local.location_short, local.vnet_verified, local.random-id_verified)]
  library_kvname  = [format("%s%sSAPLIBprvt%s",local.env_verified, local.location_short, local.random-id_verified,
    format("%s%sSAPLIBuser%s",local.env_verified, local.location_short, local.random-id_verified)]

}
