# Generates random text for boot diagnostics storage account name
resource random_id deploy-random-id {
  keepers = {
    # Generate a new id only when a new resource group is defined
    prefix = format("%s-%s-%s_%s",local.environment,local.location, local.vnet_mgmt_name_part, local.codename)
  }
  byte_length = 4
}