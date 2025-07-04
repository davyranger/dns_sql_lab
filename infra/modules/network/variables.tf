variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  type        = string
}

variable "location" {
  description = "The Azure region in which the resources will be created."
  type        = string
}

variable "sql_server_id" {
  description = "Resource ID of the SQL Server"
  type        = string
}

