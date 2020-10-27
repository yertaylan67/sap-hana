output "nics-scs" {
  value = azurerm_network_interface.scs
}

output "nics-app" {
  value = azurerm_network_interface.app
}

output "nics-web" {
  value = azurerm_network_interface.web
}

output "app_vm_names" {
  value = upper(local.app_ostype) == "LINUX" ? (
    azurerm_linux_virtual_machine.app.*.name) : (
    azurerm_windows_virtual_machine.app.*.name
  )
}

output "app_computer_names" {
  value = upper(local.app_ostype) == "LINUX" ? (
    azurerm_linux_virtual_machine.app.*.computername) : (
    azurerm_windows_virtual_machine.app.*.computername
  )
}

output "scs_vm_names" {
  value = upper(local.scs_ostype) == "LINUX" ? (
    azurerm_linux_virtual_machine.scs.*.name) : (
    azurerm_windows_virtual_machine.scs.*.name
  )
}

output "scs_computer_names" {
  value = upper(local.scs_ostype) == "LINUX" ? (
    azurerm_linux_virtual_machine.scs.*.computername) : (
    azurerm_windows_virtual_machine.scs.*.computername
  )
}

output "web_vm_names" {
  value = upper(local.web_ostype) == "LINUX" ? (
    azurerm_linux_virtual_machine.web.*.name) : (
    azurerm_windows_virtual_machine.web.*.name
  )
}

output "web_computer_names" {
  value = upper(local.web_ostype) == "LINUX" ? (
    azurerm_linux_virtual_machine.web.*.computername) : (
    azurerm_windows_virtual_machine.web.*.computername
  )
}


output "scs_lb_name" {
  value = azurerm_lb.scs.*.name
}

output "web_lb_name" {
  value = azurerm_lb.web.*.name
}

output "app_ip" {
  value = azurerm_network_interface.app.*.private_ip_address
}

output "app_admin_ip" {
  value = azurerm_network_interface.app-admin.*.private_ip_address
}

output "scs_ip" {
  value = azurerm_network_interface.scs.*.private_ip_address
}

output "scs_admin_ip" {
  value = azurerm_network_interface.scs-admin.*.private_ip_address
}

output "web_ip" {
  value = azurerm_network_interface.web.*.private_ip_address
}

output "web_admin_ip" {
  value = azurerm_network_interface.web-admin.*.private_ip_address
}

output "web_lb_ip" {
  value = azurerm_lb.web.*.private_ip_address
}

output "scs_lb_ip" {
  value = azurerm_lb.scs.*.private_ip_address
}

output "ers_lb_ip" {
  value = azurerm_lb.web.*.private_ip_address
}
