# Generates random text for boot diagnostics storage account name
resource random_id deploy-random-id {
  keepers = {
    # Generate a new id only when a new resource group is defined
    prefix = module.sap_namegenerator.prefixes["SDU"]
  }
  byte_length = 4
} 