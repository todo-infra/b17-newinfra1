resource "azurerm_mssql_database" "db" {
  name         = var.db_name 
  server_id    = data.azurerm_mssql_server.server_id.id
  sku_name     = "S0"
  enclave_type = "VBS"
}