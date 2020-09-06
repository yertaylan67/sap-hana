locals {

  sdu_name      = length(var.codename) > 0 ? upper(format("%s-%s-%s_%s-%s", local.env_verified, local.location_short, local.vnet_verified, var.codename, var.sap_sid)) : upper(format("%s-%s-%s-%s", local.env_verified, local.location_short, local.vnet_verified, var.sap_sid))
  deployer_name = upper(format("%s-%s-%s", local.env_verified, local.location_short, local.dep_vnet_verified))
  vnet_name     = upper(format("%s-%s-%s", local.env_verified, local.location_short, local.vnet_verified))
  library_name  = upper(format("%s-%s", local.env_verified, local.location_short))

  sa_prefix = lower(format("%s%s%sdiag", local.env_verified, local.location_short, local.vnet_verified))

}
