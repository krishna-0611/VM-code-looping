data "azurerm_key_vault" "keyvault-rg" {
  name                = "krishnakv"
  resource_group_name = "keyvault-rg1"
}

data "azurerm_key_vault_secret" "keyvault-98" {
  name         = "krishna"
  key_vault_id = data.azurerm_key_vault.keyvault-rg.id
}

data "azurerm_key_vault_secret" "hiddenkv" {
  name         = "password"
  key_vault_id = data.azurerm_key_vault.keyvault-rg.id
}