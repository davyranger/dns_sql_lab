resource "azurerm_mssql_server" "sql_server" {
  name                          = "example-sqlserver123"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  version                       = "12.0"
  public_network_access_enabled = false
  administrator_login           = var.sql_admin_username
  administrator_login_password  = var.sql_admin_password
}

resource "azurerm_mssql_database" "sql_db" {
  name      = "exampledb"
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = "S0"
}