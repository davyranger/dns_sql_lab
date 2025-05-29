resource "azurerm_bastion_host" "bastion" {
  name                = "my-bastion-host"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = var.bastion_subnet
    public_ip_address_id = var.bastion_public_ip
  }
}


resource "azurerm_linux_virtual_machine" "vm" {
  name                = "linux-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1s"
  admin_username      = var.va_username
  network_interface_ids = [
    var.network_interface_id,
  ]

  admin_password                  = var.va_password # only if ssh keys aren't used
  disable_password_authentication = false
  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    environment = "demo"
  }
}