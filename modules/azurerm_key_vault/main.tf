data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "keyvault" {
    for_each = var.key_vault
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled
  sku_name = each.value.sku_name
  rbac_authorization_enabled = true

}


resource "azurerm_role_assignment" "keyvault_admin" {
    depends_on = [ azurerm_key_vault.keyvault ]
    for_each = var.key_vault
  scope                = azurerm_key_vault.keyvault[each.key].id
  role_definition_name = each.value.role_display_name
  principal_id         = data.azurerm_client_config.current.object_id
}