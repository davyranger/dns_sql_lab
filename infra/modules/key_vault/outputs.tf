output "azure_key_vault_id" {
  value = azurerm_key_vault.vault.id
}

output "vm_admin_username" {
  value     = random_pet.vm_admin_username.id
  sensitive = true
}

output "vm_admin_password" {
  value     = random_password.vm_admin_password.result
  sensitive = true
}

output "sql_admin_username" {
  value     = random_pet.sql_admin_username.id
  sensitive = true
}

output "sql_admin_password" {
  value     = random_password.sql_admin_password.result
  sensitive = true
}
