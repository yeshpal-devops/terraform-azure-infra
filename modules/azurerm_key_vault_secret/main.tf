resource "azurerm_key_vault_secret" "key_vault_secret" {
  for_each     = var.vault_secret
  name         = each.value.name
  value        = sensitive(each.value.value)
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.value.key_vault_key].id
}


