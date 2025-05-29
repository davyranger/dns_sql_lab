resource "azurerm_key_vault" "vault" {
  name                       = "dstsqlkeyvault"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id # current service principal

    key_permissions = [
      "Create",
      "Get",
      "List"
    ]

    secret_permissions = [
      "Set",
      "Get",
      "List",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "4c29f6a2-c1c9-4ab0-932a-4cc7fd5e7a9c" # user davy_admin

    key_permissions = [
      "Create",
      "Get",
      "List"
    ]

    secret_permissions = [
      "Set",
      "Get",
      "List",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}


# Generate strong VM admin password
resource "random_password" "vm_admin_password" {
  length  = 20
  special = true
}

# Generate strong SQL admin password
resource "random_password" "sql_admin_password" {
  length  = 20
  special = true
}

# Static or semi-random usernames if needed
resource "random_pet" "vm_admin_username" {
  length = 2
}

resource "random_pet" "sql_admin_username" {
  length = 2
}

resource "azurerm_key_vault_secret" "vm_admin_username" {
  name         = "VMAdminUsername"
  value        = random_pet.vm_admin_username.id
  key_vault_id = azurerm_key_vault.vault.id
}

resource "azurerm_key_vault_secret" "vm_admin_password" {
  name         = "VMAdminPassword"
  value        = random_password.vm_admin_password.result
  key_vault_id = azurerm_key_vault.vault.id
}

resource "azurerm_key_vault_secret" "sql_admin_username" {
  name         = "sql-admin-username"
  value        = random_pet.sql_admin_username.id
  key_vault_id = azurerm_key_vault.vault.id
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-password"
  value        = random_password.sql_admin_password.result
  key_vault_id = azurerm_key_vault.vault.id
}

