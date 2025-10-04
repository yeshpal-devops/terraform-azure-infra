module "rg" {
  source = "../../modules/azurerm_resource_group"
  rg     = var.rg
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_virtual_network"
  vnet       = var.vnet
}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../../modules/azurerm_subnet"
  subnet     = var.subnet
}

module "vm" {
  depends_on   = [module.nic, module.pip, module.subnet, module.key_vault, module.vault_secret, module.vnet, module.rg]
  source       = "../../modules/azurerm_virtual_machine"
  vm           = var.vm
  key_vault    = var.key_vault
  vault_secret = var.vault_secret
  nic          = var.nic
}

module "pip" {
  depends_on = [module.vnet, module.subnet]
  source     = "../../modules/azurerm_public_ip"
  pip        = var.pip
}

module "nic" {
  depends_on = [module.pip, module.subnet, module.vnet]
  source     = "../../modules/azurerm_network_interface"
  nic        = var.nic
  subnet     = var.subnet
}

module "key_vault" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_key_vault"
  key_vault  = var.key_vault
}

module "vault_secret" {
  depends_on   = [module.rg, module.key_vault]
  source       = "../../modules/azurerm_key_vault_secret"
  vault_secret = var.vault_secret
  key_vault    = var.key_vault
  key_vault_id = var.key_vault_id
}
