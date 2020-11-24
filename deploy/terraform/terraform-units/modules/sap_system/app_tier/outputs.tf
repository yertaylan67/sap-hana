output "nics_scs" {
  value = azurerm_network_interface.scs
}

output "nics_app" {
  value = azurerm_network_interface.app
}

output "nics_web" {
  value = azurerm_network_interface.web
}

output "nics_scs_admin" {
  value = azurerm_network_interface.scs_admin
}

output "nics_app_admin" {
  value = azurerm_network_interface.app_admin
}

output "nics_web_admin" {
  value = azurerm_network_interface.web_admin
}

output "app_ip" {
  value = azurerm_network_interface.app[*].private_ip_address
}

output "app_admin_ip" {
  value = azurerm_network_interface.app_admin[*].private_ip_address
}

output "scs_ip" {
  value = azurerm_network_interface.scs[*].private_ip_address
}

output "scs_admin_ip" {
  value = azurerm_network_interface.scs_admin[*].private_ip_address
}

output "web_ip" {
  value = azurerm_network_interface.web[*].private_ip_address
}

output "web_admin_ip" {
  value = azurerm_network_interface.web_admin[*].private_ip_address
}

output "web_lb_ip" {
  value = local.enable_deployment && local.webdispatcher_count > 0 ? azurerm_lb.web[0].frontend_ip_configuration[0].private_ip_address : ""
}

output "scs_lb_ip" {
  value = local.enable_deployment ? azurerm_lb.scs[0].frontend_ip_configuration[0].private_ip_address : ""
}

output "ers_lb_ip" {
  value = local.enable_deployment ? azurerm_lb.scs[0].frontend_ip_configuration[1].private_ip_address : ""
}

output "application" {
  value = local.application
}

// Output for DNS
output "dns_info_vms" {
  value = local.enable_deployment ? (
    local.apptier_dual_nics ? (
      zipmap(
        concat(local.full_appserver_names,
          var.naming.virtualmachine_names.APP_SECONDARY_DNSNAME,
          local.full_scsserver_names,
          var.naming.virtualmachine_names.SCS_SECONDARY_DNSNAME,
          local.full_webserver_names,
          var.naming.virtualmachine_names.WEB_SECONDARY_DNSNAME
        ),
        concat(azurerm_network_interface.app_admin[*].private_ip_address,
          azurerm_network_interface.app[*].private_ip_address,
          azurerm_network_interface.scs_admin[*].private_ip_address,
          azurerm_network_interface.scs[*].private_ip_address,
          azurerm_network_interface.web_admin[*].private_ip_address,
          azurerm_network_interface.web[*].private_ip_address
      ))) : (
      zipmap(
        concat(local.full_appserver_names,
          local.full_scsserver_names,
          local.full_webserver_names
        ),
        concat(azurerm_network_interface.app[*].private_ip_address,
          azurerm_network_interface.scs[*].private_ip_address,
          azurerm_network_interface.web[*].private_ip_address
      ))
    )
    ) : (
    null
  )
}

output "dns_info_loadbalancers" {
  value = ! local.enable_deployment ? null : (
    zipmap(
      [
        local.scs_server_count > 0 ? format("%s%s%s", local.prefix, var.naming.separator, "scs") : "",
        local.scs_server_count > 0 ? format("%s%s%s", local.prefix, var.naming.separator, "ers") : "",
        local.webdispatcher_count > 0 ? format("%s%s%s", local.prefix, var.naming.separator, local.resource_suffixes.web_alb) : ""
      ],
      [
        local.scs_server_count > 0 ? azurerm_lb.scs[0].private_ip_addresses[0] : "",
        local.scs_server_count > 0 ? azurerm_lb.scs[0].private_ip_addresses[1] : "",
        local.webdispatcher_count > 0 ? azurerm_lb.web[0].private_ip_address : ""
      ]
    )
  )
}
