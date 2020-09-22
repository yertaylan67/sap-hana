/*
  Description:
  Setup sap library
*/
module "sap_library" {
  source                  = "../../terraform-units/modules/sap_library"
  infrastructure          = var.infrastructure
  storage_account_sapbits = var.storage_account_sapbits
  storage_account_tfstate = var.storage_account_tfstate
  prefix                  = module.sap_namegenerator.prefixes["LIBRARY"]
  sa_names                = module.sap_namegenerator.sa_name["LIBRARY"]
  kv_names                = module.sap_namegenerator.kv_names["LIBRARY"]
  resource_suffixes       = module.sap_namegenerator.resource_extensions

}

module sap_namegenerator {
  source      = "../../terraform-units/modules/sap_namegenerator"
  environment = lower(try(var.infrastructure.landscape, ""))
  location    = try(var.infrastructure.region, "")
  random-id   = random_id.lib-random-id.hex

  //These are not needed for the library
  codename           = ""
  deployer_vnet_name = ""
  sap_vnet_name      = ""
  sap_sid            = ""
  hdb_sid            = ""
}

