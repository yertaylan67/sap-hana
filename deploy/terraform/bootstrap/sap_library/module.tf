/*
  Description:
  Setup sap library
*/
module sap_library {
  source                  = "../../terraform-units/modules/sap_library"
  infrastructure          = var.infrastructure
  storage_account_sapbits = var.storage_account_sapbits
  storage_account_tfstate = var.storage_account_tfstate
  prefix               = module.sap_namegenerator.prefix["LIBRARY"]
  storageaccount_names = module.sap_namegenerator.storageaccount_names["LIBRARY"]
  keyvault_names       = module.sap_namegenerator.keyvault_names["LIBRARY"]
  resource_suffixes    = module.sap_namegenerator.resource_extensions

}

module sap_namegenerator {
  source      = "../../terraform-units/modules/sap_namegenerator"
  environment = lower(try(var.infrastructure.landscape, ""))
  location    = try(var.infrastructure.region, "")
  random-id   = random_id.lib-random-id.hex

  //These are not needed for the library
  codename             = ""
  management_vnet_name = ""
  sap_vnet_name        = ""
  sap_sid              = ""
  db_sid               = ""
}

