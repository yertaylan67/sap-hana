/*
Description:
  Constraining provider versions
    =    (or no operator): exact version equality
    !=   version not equal
    >    greater than version number
    >=   greater than or equal to version number
    <    less than version number
    <=   less than or equal to version number
    ~>   pessimistic constraint operator, constraining both the oldest and newest version allowed.
           For example, ~> 0.9   is equivalent to >= 0.9,   < 1.0 
                        ~> 0.8.4 is equivalent to >= 0.8.4, < 0.9
*/

provider "azurerm" {
  version = "~> 2.10"
  features {}
  alias = "deployer"
}

locals {
  kv_id = "/subscriptions/c4106f40-4f28-442e-b67f-a24d892bf7ad/resourceGroups/azure-test-saplandscape-rg/providers/Microsoft.KeyVault/vaults/saplandscapekv01"
}

data "azurerm_key_vault_secret" "example" {
  provider     = azurerm.deployer
  name         = "clientsecret"
  key_vault_id = local.kv_id
}

provider "azurerm" {
  version = "~> 2.10"
  features {}
  alias = "saplandscape"
  subscription_id = "91a338db-aa0d-4a34-aed0-dbbbc698de30"
  client_id       = "3c92fc23-f20b-4f10-995f-69b851e0452a"
  client_secret   = data.azurerm_key_vault_secret.example.value
  tenant_id       = "72f988bf-86f1-41af-91ab-2d7cd011db47"
}

provider "azurerm" {
  version = "~> 2.10"
  features {}
  subscription_id = "91a338db-aa0d-4a34-aed0-dbbbc698de30"
  client_id       = "3c92fc23-f20b-4f10-995f-69b851e0452a"
  client_secret   = data.azurerm_key_vault_secret.example.value
  tenant_id       = "72f988bf-86f1-41af-91ab-2d7cd011db47"
}

terraform {
  required_version = ">= 0.12"
  required_providers {
    external = { version = "~> 1.2" }
    local    = { version = "~> 1.4" }
    random   = { version = "~> 2.2" }
    null     = { version = "~> 2.1" }
  }
}
