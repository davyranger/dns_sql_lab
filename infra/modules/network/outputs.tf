output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "azurerm_subnet_bastion_subnet_id" {
  value = azurerm_subnet.bastion_subnet.id
}

output "azurerm_bastion_public_ip_id" {
  value = azurerm_public_ip.bastion_ip.id
}

output "vm_nic_id" {
  value = azurerm_network_interface.vm_nic.id
}
