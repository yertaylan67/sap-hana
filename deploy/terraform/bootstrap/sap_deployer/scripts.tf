/*
Description:

  Generate post-deployment scripts.

*/

resource "local_file" "scp" {
  count =  local.enable_vm ? 1 : 0
  content = templatefile("${path.module}/deployer_scp.tmpl", {
    user_vault_name = module.sap_deployer.user_vault_name,
    ppk_name        = module.sap_deployer.ppk_name,
    pwd_name        = module.sap_deployer.pwd_name,
    deployers       = module.sap_deployer.deployers,
    deployer-ips    = module.sap_deployer.deployer_pip[*].ip_address
  })
  filename             = "${path.cwd}/post_deployment.sh"
  file_permission      = "0770"
  directory_permission = "0770"
}
