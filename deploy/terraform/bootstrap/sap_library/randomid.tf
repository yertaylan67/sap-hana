# Generates random text for resources
resource random_id lib-random-id {
  keepers = {
    # Generate a new id only when a new resource group is defined
    prefix = module.sap_library.resource_group_name
  }
  byte_length = 4
}
