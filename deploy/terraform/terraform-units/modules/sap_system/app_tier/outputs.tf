output "nics-scs" {
  value = azurerm_network_interface.scs
}

output "nics-app" {
  value = azurerm_network_interface.app
}

output "nics-web" {
  value = azurerm_network_interface.web
}

output "app_ip" {
  value = azurerm_network_interface.app.ip_configuration.private_ip_address
}

output "app_admin_ip" {
  value = azurerm_network_interface.app-admin.ip_configuration.private_ip_address
}

output "scs_ip" {
  value = azurerm_network_interface.scs.ip_configuration.private_ip_address
}

output "scs_admin_ip" {
  value = azurerm_network_interface.scs-admin.ip_configuration.private_ip_address
}

output "scs_ip" {
  value = azurerm_network_interface.scs.ip_configuration.private_ip_address
}

output "scs_admin_ip" {
  value = azurerm_network_interface.scs-admin.ip_configuration.private_ip_address
}

output "web_lb_ip" {
  value =  azurerm_lb.web.frontend_ip_configuration.private_ip_address
}

output "scs_lb_ip" {
  value =  azurerm_lb.scs.frontend_ip_configuration[0].private_ip_address
}

output "ers_lb_ip" {
  value =  azurerm_lb.web.frontend_ip_configuration[1].private_ip_address
}
