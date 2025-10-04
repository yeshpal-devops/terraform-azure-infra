data "azurerm_key_vault" "keyvault" {
  for_each = var.key_vault
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "vault_secret" {
  for_each     = var.vault_secret
  name         = each.value.name
  key_vault_id = data.azurerm_key_vault.keyvault[each.value.key_vault_key].id
}

data "azurerm_network_interface" "nic" {
  for_each = var.nic
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}
