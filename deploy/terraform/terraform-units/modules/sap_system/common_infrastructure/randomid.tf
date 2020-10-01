# Generates random text for boot diagnostics storage account name
resource "random_id" "random-id" {
  byte_length = 4
} 
