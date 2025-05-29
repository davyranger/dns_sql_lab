resource "azurerm_key_vault_access_policy" "vm" {
  key_vault_id = var.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.vm_principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}
