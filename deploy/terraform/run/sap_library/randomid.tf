# Generates random text for boot diagnostics storage account name
resource random_id lib-random-id {
  keepers = {
    
    prefix = module.sap_namegenerator.prefix["LIBRARY"]
  }
  byte_length = 4
}
