variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  type        = string
}

variable "location" {
  description = "The Azure region in which the resources will be created."
  type        = string
}

variable "sql_admin_username" {
  description = "The username for the SQL Server admin, stored in Key Vault."
  type        = string
}

variable "sql_admin_password" {
  description = "The password for the SQL Server admin, stored in Key Vault."
  type        = string
}
