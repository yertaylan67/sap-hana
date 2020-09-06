locals {

  sdu_name      = length(var.codename) > 0 ? upper(format("%s-%s-%s_%s-%s", local.env_verified, local.location_short, local.vnet_verified, var.codename, var.sap_sid)) : upper(format("%s-%s-%s-%s", local.env_verified, local.location_short, local.vnet_verified, var.sap_sid))
  deployer_name = upper(format("%s-%s-%s", local.env_verified, local.location_short, local.dep_vnet_verified))
  vnet_name     = upper(format("%s-%s-%s", local.env_verified, local.location_short, local.vnet_verified))
  library_name  = upper(format("%s-%s", local.env_verified, local.location_short))

  sdu_sa_name      = lower(format("%s%s%sdiag%s", local.env_verified, local.location_short, local.vnet_verified, local.random-id_verified))
  library_sa_name  = lower(format("%s%s%ssaplib%s", local.env_verified, local.location_short, local.vnet_verified, local.random-id_verified))
  state_sa_name    = lower(format("%s%s%stfstate%s", local.env_verified, local.location_short, local.vnet_verified, local.random-id_verified))
  deployer_sa_name = lower(format("%s%s%sdiag%s", local.env_verified, local.location_short, local.dep_vnet_verified, local.random-id_verified))
  vnet_sa_name     = lower(format("%s%s%sdiag%s", local.env_verified, local.location_short, local.dep_vnet_verified, local.random-id_verified))

}
