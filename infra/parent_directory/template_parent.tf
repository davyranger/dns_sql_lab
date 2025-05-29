module "key_vault_access_policies" {
  source              = "../modules/key_vault_access_policies"
  key_vault_id        = module.key_vault.azure_key_vault_id
  vm_principal_id     = module.virtual_machine.vm_principal_id
  resource_group_name = module.network.resource_group_name
  location            = var.location
  depends_on          = [module.key_vault]
}


module "key_vault" {
  source              = "../modules/key_vault"
  resource_group_name = module.network.resource_group_name
  location            = var.location
}

module "virtual_machine" {
  source               = "../modules/virtual_machine"
  resource_group_name  = module.network.resource_group_name
  location             = var.location
  va_username          = module.key_vault.vm_admin_username
  va_password          = module.key_vault.vm_admin_password
  bastion_subnet       = module.network.azurerm_subnet_bastion_subnet_id
  bastion_public_ip    = module.network.azurerm_bastion_public_ip_id
  network_interface_id = module.network.vm_nic_id
  depends_on           = [module.key_vault]
}

module "sql_server" {
  source              = "../modules/sql_server"
  resource_group_name = module.network.resource_group_name
  location            = var.location
  sql_admin_username  = module.key_vault.sql_admin_username
  sql_admin_password  = module.key_vault.sql_admin_password
  depends_on          = [module.key_vault]
}

module "network" {
  source              = "../modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  sql_server_id       = module.sql_server.sql_server_id
}