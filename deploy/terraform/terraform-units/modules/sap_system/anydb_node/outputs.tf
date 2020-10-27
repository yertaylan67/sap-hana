output "nics-anydb" {
  value = azurerm_network_interface.anydb_db
}

output "anydb_vm_names" {
  value = local.virtualmachine_names
  }

output "anydb_computer_names" {
  value = local.computer_names
}

output "db_lb_name" {
  value = azurerm_lb.anydb.*.name
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
