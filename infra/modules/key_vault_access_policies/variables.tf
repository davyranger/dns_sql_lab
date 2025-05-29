variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  type        = string
}

variable "location" {
  description = "The Azure region in which the resources will be created."
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Azure Key Vault."
  type        = string
}

variable "vm_principal_id" {
  type        = string
  description = "The principal ID of the virtual machine's managed identity"
}

