// Output IP Addresses

output "anydb_admin_ip" {
  value = module.anydb_node.anydb_admin_ip
}

output "anydb_db_ip" {
  value = module.anydb_node.anydb_db_ip
}

output "anydb_lb_ip" {
  value = module.anydb_node.anydb_db_ip.anydb_lb_ip
}
