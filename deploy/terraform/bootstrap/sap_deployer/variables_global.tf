/*
Description:

  Define input variables.
*/

variable "deployers" {
  description = "Details of the list of deployer(s)"
  default     = [{}]
}

variable "infrastructure" {
  description = "Details of the Azure infrastructure to deploy the SAP landscape into"
  default     = {}
}

variable "options" {
  description = "Configuration options"
  default     = {}
}

variable "ssh-timeout" {
  description = "Timeout for connection that is used by provisioner"
  default     = "30s"
}

variable "sshkey" {
  description = "Details of ssh key pair"
  default     = {}
}

variable "user_key_vault_id" {
  description = "The user brings an existing user Key Vault"
  default     = ""
}

variable "private_key_vault_id" {
  description = "The user brings an existing private Key Vault"
  default     = ""
}

variable "public_key_secret_name" {
  description = "The user brings a public key in the existing Key Vault"
  default     = ""
}

variable "private_key_secret_name" {
  description = "The user brings a private key in the existing Key Vault"
  default     = ""
}

variable "password_secret_name" {
  description = "The user brings a password in the existing Key Vault"
  default     = ""
}
