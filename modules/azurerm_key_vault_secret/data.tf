data "azurerm_key_vault" "key_vault_id" {
  for_each = var.key_vault
  name  = each.value.name
  resource_group_name = each.value.resource_group_name
}
