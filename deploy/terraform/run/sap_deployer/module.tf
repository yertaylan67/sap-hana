/*
Description:

  Example to deploy deployer(s) using local backend.
*/
module "sap_deployer" {
  source            = "../../terraform-units/modules/sap_deployer/"
  infrastructure    = var.infrastructure
  deployers         = var.deployers
  options           = var.options
  ssh-timeout       = var.ssh-timeout
  sshkey            = var.sshkey
  prefix            = module.sap_namegenerator.prefixes["DEPLOYER"]
  sa_name           = module.sap_namegenerator.sa_name["DEPLOYER"]
  vm_names          = module.sap_namegenerator.vm_names["DEPLOYER"]
  kv_names          = module.sap_namegenerator.kv_names["DEPLOYER"]
  resource_suffixes = module.sap_namegenerator.resource_extensions
}

module "sap_namegenerator" {
  source               = "../../terraform-units/modules/sap_namegenerator"
  environment          = lower(try(var.infrastructure.landscape, ""))
  location             = try(var.infrastructure.region, "")
  codename             = lower(try(var.infrastructure.codename, ""))
  management_vnet_name = try(var.infrastructure.vnets.management.name, "MGMT")
  random-id            = random_id.deploy-random-id.hex
  //These are not needed for the deployer
  sap_vnet_name        = try(var.infrastructure.vnets.sap.name, "")
  sap_sid              = ""
  db_sid               = ""

}

