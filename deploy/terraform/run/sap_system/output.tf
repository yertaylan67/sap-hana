// Output IP Addresses

output "anydb_admin_ip" {
  value = azurerm_network_interface.anydb_admin.*.ip_configuration.private_ip_address
}

output "anydb_db_ip" {
  value = azurerm_network_interface.anydb_db.*.ip_configuration.private_ip_address
}

output "anydb_lb_ip" {
  value = azurerm_lb.anydb.*.frontend_ip_configuration.private_ip_address
}
