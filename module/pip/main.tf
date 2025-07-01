resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = var.rg_name
  location            = var.pip_location
  allocation_method   = var.allocation_method
  sku = var.sku_basic_features
}