data "azurerm_mssql_server" "server_id" {
  name                = var.server-name
  resource_group_name = var.rg_name 
}