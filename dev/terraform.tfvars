rg = {
  dev_resource_group = {
    name     = "dev-rg"
    location = "East US"
  }
}

vnet = {
  dev_virtual_network = {
    name                = "dev-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = "East US"
    resource_group_name = "dev-rg"
  }
}

subnet = {
  dev_subnet = {
    name                 = "dev-subnet"
    resource_group_name  = "dev-rg"
    address_prefixes     = ["10.0.1.0/24"]
    virtual_network_name = "dev-vnet"
  }
}

pip = {
  dev_pip = {
    name                = "dev-pip"
    resource_group_name = "dev-rg"
    location            = "East US"
    allocation_method   = "Static"
  }
}


nic = {
  dev_nic = {
    name                          = "dev-nic"
    location                      = "East US"
    resource_group_name           = "dev-rg"
    ip_configuration_name         = "dev-ip-config"
    subnet_key                    = "dev_subnet"
    private_ip_address_allocation = "Dynamic"
  }
}



data-subnet = {
  subnet_id = {
    virtual_network_name = "dev-vnet"
    resource_group_name  = "dev-rg"
  }
}
key_vault = {
  vault = {     
    name                        = "seckeyvault2025" 
    location                    = "East US"
    resource_group_name         = "dev-rg"
    enabled_for_disk_encryption = true
    tenant_id                   = "46acc839-0dfd-4c5d-af6a-039742750cf8"
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
    read_access_enabled         = true
    role_display_name           = "Key Vault Administrator"
  }
}

key_vault_id = {
  vault = {        
    name                = "dev-key-vault"
    resource_group_name = "dev-rg"
  }
}

vault_secret = {
  secret = {
    name          = "dev-vault-secret"
    value         = "supersecretvalue"
    key_vault_key = "vault"         
  }

  vm_admin_username = {
    name          = "vm-admin-username"
    value         = "adminuser"
    key_vault_key = "vault"          
  }

  vm_admin_password = {
    name          = "vm-admin-password"
    value         = "AnotherSuperSecretValue"
    key_vault_key = "vault"         
  }
}



vm = {
  devvm = {  
    name                            = "dev-vm"
    resource_group_name             = "dev-rg"
    location                        = "East US"
    vm_size                         = "Standard_E2s_v3"
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "MicrosoftWindowsServer"
    offer                           = "WindowsServer"
    sku                             = "2019-Datacenter"
    version                         = "latest"
    disable_password_authentication = false
    admin_username                  = "adminuser"
    admin_password                   = "AdminUser@123"
    nic                              = "dev_nic"
    key_vault                        = "dev-key-vault"
  }
}

