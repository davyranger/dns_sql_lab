# Load all YAML files
locals {
  yaml_files = fileset("${path.module}/../../../data", "*.yaml")

  nsg_data = merge([
    for file in local.yaml_files : try(
      yamldecode(file("${path.module}/../../../data/${file}")),
      {}
    )
  ]...)
}

resource "azurerm_network_security_group" "app_nsg" {
  for_each            = local.nsg_data
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = each.value.rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = try(security_rule.value.destination_port_range, null)
      destination_port_ranges    = try(security_rule.value.destination_port_ranges, [])
      protocol                   = security_rule.value.protocol
      source_address_prefix      = try(security_rule.value.source_address_prefix, null)
      destination_address_prefix = try(security_rule.value.destination_address_prefix, null)
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each = local.nsg_data

  subnet_id                 = data.azurerm_subnet.subnet_by_subnet_name[each.value.subnet_name].id
  network_security_group_id = azurerm_network_security_group.app_nsg[each.key].id
}
