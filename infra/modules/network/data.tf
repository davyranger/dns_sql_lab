data "azurerm_client_config" "current" {}

data "azurerm_subnet" "subnet_by_subnet_name" {
  for_each = {
    for k, v in local.nsg_data : v.subnet_name => v
    # k, v in local.nsg_data - Iterate over all items in your YAML/map
    # v.subnet_name => v - Create a map with subnet_name as key
  }

  name                 = each.key
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  depends_on = [
    azurerm_subnet.private_subnet,
    azurerm_subnet.bastion_subnet
  ]
}


