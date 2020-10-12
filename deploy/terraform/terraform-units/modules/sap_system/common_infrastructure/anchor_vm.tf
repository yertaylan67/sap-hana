data "azurerm_subnet" "anchor" {
  count                = local.zonal_deployment ? (local.sub_db_exists ? 1 : 0) : 0
  name                 = split("/", local.sub_db_arm_id)[10]
  resource_group_name  = split("/", local.sub_db_arm_id)[4]
  virtual_network_name = split("/", local.sub_db_arm_id)[8]
}


# Create Anchor VM
resource "azurerm_network_interface" "anchor" {
  count                         = local.zonal_deployment ? length(local.zones) : 0
  name                          = format("%s_anchor%02d_z%s%s", local.prefix, count.index, local.zones[count.index], local.resource_suffixes.nic)
  resource_group_name          = local.rg_exists ? data.azurerm_resource_group.resource-group[0].name : azurerm_resource_group.resource-group[0].name
  location                     = local.rg_exists ? data.azurerm_resource_group.resource-group[0].location : azurerm_resource_group.resource-group[0].location
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "IPConfig1"
    subnet_id                     = data.azurerm_subnet.anchor[0].id
    private_ip_address_allocation = "dynamic"
  }
}

# Create the Linux Application VM(s)
resource "azurerm_linux_virtual_machine" "app" {
  count                        = local.zonal_deployment ? length(local.zones) : 0
  name                         = format("%s_anchor%02d_z%s%s", local.prefix, count.index, local.zones[count.index], local.resource_suffixes.vm)
  computer_name                = format("anchor%02dz%s%s", count.index, local.zones[count.index], local.resource_suffixes.vm)
  resource_group_name          = local.rg_exists ? data.azurerm_resource_group.resource-group[0].name : azurerm_resource_group.resource-group[0].name
  location                     = local.rg_exists ? data.azurerm_resource_group.resource-group[0].location : azurerm_resource_group.resource-group[0].location
  proximity_placement_group_id = azurerm_proximity_placement_group.ppg[count.index].id
  zone                         = local.zones[count.index]

  network_interface_ids = [
    azurerm_network_interface.anchor[count.index].id
  ]
  size                            = local.anchor_size
  admin_username                  = local.authentication.username
  disable_password_authentication = true

  os_disk {
    name                 = format("%s_anchor%02d_z%s%s", local.prefix, count.index, local.zones[count.index], local.resource_suffixes.osdisk)
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = local.anchor_custom_image ? local.anchor.os.source_image_id : null

  dynamic "source_image_reference" {
    for_each = range(local.anchor_custom_image ? 0 : 1)
    content {
      publisher = local.anchor.os.publisher
      offer     = local.anchor.os.offer
      sku       = local.anchor.os.sku
      version   = local.anchor.os.version
    }
  }

  admin_ssh_key {
    username   = local.authentication.username
    public_key = file(var.sshkey.path_to_public_key)
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.storage-bootdiag.primary_blob_endpoint
  }
}

