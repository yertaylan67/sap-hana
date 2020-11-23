/*
Description:

  Example to deploy deployer(s) using local backend.
*/
module "sap_deployer" {
  source                  = "../../terraform-units/modules/sap_deployer"
  infrastructure          = var.infrastructure
  deployers               = var.deployers
  options                 = var.options
  ssh-timeout             = var.ssh-timeout
  sshkey                  = var.sshkey
  user_key_vault_id       = var.user_key_vault_id
  private_key_vault_id    = var.private_key_vault_id
  public_key_secret_name  = var.public_key_secret_name
  private_key_secret_name = var.private_key_secret_name
  password_secret_name    = var.password_secret_name
  naming                  = module.sap_namegenerator.naming
}

module "sap_namegenerator" {
  source               = "../../terraform-units/modules/sap_namegenerator"
  environment          = local.environment
  location             = local.location
  codename             = local.codename
  management_vnet_name = local.vnet_mgmt_name_part
  random_id            = module.sap_deployer.random_id
  deployer_vm_count    = local.deployer_vm_count
}
