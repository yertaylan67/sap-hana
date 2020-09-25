# Generates random text for boot diagnostics storage account name
resource random_id deploy-random-id {
  
  byte_length = 4
}