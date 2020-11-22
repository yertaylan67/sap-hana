# Create Web dispatcher NICs
resource "azurerm_network_interface" "web" {
  count                         = local.enable_deployment ? local.webdispatcher_count : 0
  name                          = format("%s%s%s%s", local.prefix, var.naming.separator, local.web_virtualmachine_names[count.index], local.resource_suffixes.nic)
  location                      = var.resource_group[0].location
  resource_group_name           = var.resource_group[0].name
  enable_accelerated_networking = local.web_sizing.compute.accelerated_networking

  ip_configuration {
    name      = "IPConfig1"
    subnet_id = local.sub_web_deployed.id
    private_ip_address = local.dynamic_ipaddresses ? (
      null) : (
      try(local.web_nic_ips[count.index], local.sub_web_defined ?
        cidrhost(local.sub_web_prefix, (tonumber(count.index) + local.ip_offsets.web_vm)) :
        cidrhost(local.sub_app_prefix, (tonumber(count.index) * -1 + local.ip_offsets.web_vm))
      )
    )
    private_ip_address_allocation = local.dynamic_ipaddresses ? "Dynamic" : "Static"
  }
}

# Create Application NICs
resource "azurerm_network_interface" "web_admin" {
  count                         = local.enable_deployment && local.apptier_dual_nics ? local.webdispatcher_count : 0
  name                          = format("%s%s%s%s", local.prefix, var.naming.separator, local.web_virtualmachine_names[count.index], local.resource_suffixes.admin_nic)
  location                      = var.resource_group[0].location
  resource_group_name           = var.resource_group[0].name
  enable_accelerated_networking = local.app_sizing.compute.accelerated_networking

  ip_configuration {
    name      = "IPConfig1"
    subnet_id = var.admin_subnet.id
    private_ip_address = local.dynamic_ipaddresses ? (
      null) : (
      try(local.web_admin_nic_ips[count.index],
        cidrhost(var.admin_subnet.address_prefixes[0], tonumber(count.index) + local.admin_ip_offsets.web_vm
        )
    ))
    private_ip_address_allocation = local.dynamic_ipaddresses ? "Dynamic" : "Static"
  }
}

# Create the Linux Web dispatcher VM(s)
resource "azurerm_linux_virtual_machine" "web" {
  count               = local.enable_deployment ? (upper(local.web_ostype) == "LINUX" ? local.webdispatcher_count : 0) : 0
  name                = format("%s%s%s%s", local.prefix, var.naming.separator, local.web_virtualmachine_names[count.index], local.resource_suffixes.vm)
  computer_name       = local.web_computer_names[count.index]
  location            = var.resource_group[0].location
  resource_group_name = var.resource_group[0].name

  //If more than one servers are deployed into a zone put them in an availability set and not a zone
  availability_set_id = local.webdispatcher_count == local.web_zone_count ? null : (
    local.web_zone_count > 1 ? (
      azurerm_availability_set.web[count.index % max(local.web_zone_count, 1)].id) : (
      azurerm_availability_set.web[0].id
    )
  )
  proximity_placement_group_id = local.web_zonal_deployment ? var.ppg[count.index % max(local.web_zone_count, 1)].id : var.ppg[0].id
  zone = local.web_zonal_deployment ? (
    local.webdispatcher_count == local.web_zone_count ? local.web_zones[count.index % max(local.web_zone_count, 1)] : null) : (
    null
  )

  network_interface_ids = local.apptier_dual_nics ? (
    [azurerm_network_interface.web_admin[count.index].id, azurerm_network_interface.web[count.index].id]) : (
    [azurerm_network_interface.web[count.index].id]
  )

  size                            = local.web_sizing.compute.vm_size
  admin_username                  = local.sid_auth_username
  disable_password_authentication = ! local.enable_auth_password
  admin_password                  = local.sid_auth_password

  os_disk {
    name                 = format("%s%s%s%s", local.prefix, var.naming.separator, local.web_virtualmachine_names[count.index], local.resource_suffixes.osdisk)
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = local.web_custom_image ? local.web_os.source_image_id : null

  dynamic "source_image_reference" {
    for_each = range(local.web_custom_image ? 0 : 1)
    content {
      publisher = local.web_os.publisher
      offer     = local.web_os.offer
      sku       = local.web_os.sku
      version   = local.web_os.version
    }
  }

  dynamic "admin_ssh_key" {
    for_each = range(local.enable_auth_password ? 0 : 1)
    content {
      username   = local.sid_auth_username
      public_key = data.azurerm_key_vault_secret.sid_pk[0].value
    }
  }

  boot_diagnostics {
    storage_account_uri = var.storage_bootdiag.primary_blob_endpoint
  }
}

# Create the Windows Web dispatcher VM(s)
resource "azurerm_windows_virtual_machine" "web" {
  count               = local.enable_deployment ? (upper(local.web_ostype) == "WINDOWS" ? local.webdispatcher_count : 0) : 0
  name                = format("%s%s%s%s", local.prefix, var.naming.separator, local.web_virtualmachine_names[count.index], local.resource_suffixes.vm)
  computer_name       = local.web_computer_names[count.index]
  location            = var.resource_group[0].location
  resource_group_name = var.resource_group[0].name

  //If more than one servers are deployed into a zone put them in an availability set and not a zone
  availability_set_id = local.webdispatcher_count == local.web_zone_count ? null : (
    local.web_zone_count > 1 ? (
      azurerm_availability_set.web[count.index % max(local.web_zone_count, 1)].id) : (
      azurerm_availability_set.web[0].id
    )
  )
  proximity_placement_group_id = local.web_zonal_deployment ? var.ppg[count.index % max(local.web_zone_count, 1)].id : var.ppg[0].id
  zone = local.web_zonal_deployment ? (
    local.webdispatcher_count == local.web_zone_count ? local.web_zones[count.index % max(local.web_zone_count, 1)] : null) : (
    null
  )

  network_interface_ids = local.apptier_dual_nics ? (
    [azurerm_network_interface.web_admin[count.index].id, azurerm_network_interface.web[count.index].id]) : (
    [azurerm_network_interface.web[count.index].id]
  )

  size           = local.web_sizing.compute.vm_size
  admin_username = local.sid_auth_username
  admin_password = local.sid_auth_password

  os_disk {
    name                 = format("%s%s%s%s", local.prefix, var.naming.separator, local.web_virtualmachine_names[count.index], local.resource_suffixes.osdisk)
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = local.web_custom_image ? local.web_os.source_image_id : null

  dynamic "source_image_reference" {
    for_each = range(local.web_custom_image ? 0 : 1)
    content {
      publisher = local.web_os.publisher
      offer     = local.web_os.offer
      sku       = local.web_os.sku
      version   = local.web_os.version
    }
  }

  boot_diagnostics {
    storage_account_uri = var.storage_bootdiag.primary_blob_endpoint
  }
}

# Creates managed data disk
resource "azurerm_managed_disk" "web" {
  count                = local.enable_deployment ? length(local.web_data_disks) : 0
  name                 = format("%s%s%s%s", local.prefix, var.naming.separator, local.web_virtualmachine_names[count.index], local.web_data_disks[count.index].suffix)
  location             = var.resource_group[0].location
  resource_group_name  = var.resource_group[0].name
  create_option        = "Empty"
  storage_account_type = local.web_data_disks[count.index].storage_account_type
  disk_size_gb         = local.web_data_disks[count.index].disk_size_gb
  zones = local.web_zonal_deployment && (local.webdispatcher_count == local.web_zone_count) ? (
    upper(local.web_ostype) == "LINUX" ? (
      [azurerm_linux_virtual_machine.web[local.web_data_disks[count.index].vm_index].zone]) : (
      [azurerm_windows_virtual_machine.web[local.web_data_disks[count.index].vm_index].zone]
    )) : (
    null
  )
}

resource "azurerm_virtual_machine_data_disk_attachment" "web" {
  count           = local.enable_deployment ? length(local.web_data_disks) : 0
  managed_disk_id = azurerm_managed_disk.web[count.index].id
  virtual_machine_id = upper(local.web_ostype) == "LINUX" ? (
    azurerm_linux_virtual_machine.web[local.web_data_disks[count.index].vm_index].id) : (
    azurerm_windows_virtual_machine.web[local.web_data_disks[count.index].vm_index].id
  )
  caching                   = local.web_data_disks[count.index].caching
  write_accelerator_enabled = local.web_data_disks[count.index].write_accelerator_enabled
  lun                       = local.web_data_disks[count.index].lun
}
