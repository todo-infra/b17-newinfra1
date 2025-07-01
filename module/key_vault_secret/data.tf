data "azurerm_key_vault_secret" "vm-username" {
  name         = "vm-user"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vm-password" {
  name         = "vm-pass"
  key_vault_id = data.azurerm_key_vault.kv.id
}