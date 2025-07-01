resource "azurerm_mssql_server" "server" {
  name                         = var.server-name 
  resource_group_name          = var.rg_name 
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_user
  administrator_login_password = var.sql_pass
  minimum_tls_version          = "1.2"
}