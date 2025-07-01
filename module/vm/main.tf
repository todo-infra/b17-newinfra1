resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.vm_location
  size                = var.vm_size
  admin_username      = data.azurerm_key_vault_secret.vm-username.value
  admin_password      = data.azurerm_key_vault_secret.vm-password.value
  disable_password_authentication = false
  custom_data         = var.custom_data
  #network_interface_ids = [
   # azurerm_network_interface.example.id,
  #]
   network_interface_ids = [var.nic_id]



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
}