output "nics_anydb" {
  value = azurerm_network_interface.anydb_db
}

output "nics_anydb_admin" {
  value = azurerm_network_interface.anydb_admin
}

output "anydb_vm_names" {
  value = upper(local.anydb_ostype) == "LINUX" ? (
    azurerm_linux_virtual_machine.dbserver.*.name) : (
    azurerm_windows_virtual_machine.dbserver.*.name
  )
}

output "anydb_computer_names" {
  value = upper(local.anydb_ostype) == "LINUX" ? (
    azurerm_linux_virtual_machine.dbserver.*.computer_name) : (
    azurerm_windows_virtual_machine.dbserver.*.computer_name
  )
}

output "db_lb_name" {
  value = azurerm_lb.anydb.*.name
}
output "nics_anydb" {
  value = azurerm_network_interface.anydb_admin
}


output "anydb_admin_ip" {
  value = azurerm_network_interface.anydb_admin.*.private_ip_address
}

output "anydb_db_ip" {
  value = azurerm_network_interface.anydb_db.*.private_ip_address
}

output "anydb_lb_ip" {
  value = azurerm_lb.anydb.*.private_ip_address
}

output "any-database-info" {
  value = try(local.enable_deployment ? local.anydb_database : map(false), {})
}

output "anydb-loadbalancers" {
  value = azurerm_lb.anydb
}
