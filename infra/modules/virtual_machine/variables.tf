variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  type        = string
}

variable "location" {
  description = "The Azure region in which the resources will be created."
  type        = string
}

variable "bastion_subnet" {
  description = "The ID of the Azure Bastion subnet."
  type        = string
}

variable "bastion_public_ip" {
  description = "The ID of the Azure Bastion public IP."
  type        = string
}
variable "network_interface_id" {
  description = "ID of the NIC to attach to the VM"
  type        = string
}

variable "va_username" {
  description = "The username for the VM admin, stored in Key Vault."
  type        = string
}

variable "va_password" {
  description = "The password for the VM admin, stored in Key Vault."
  type        = string
}

