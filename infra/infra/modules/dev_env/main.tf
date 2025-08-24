resource "azurerm_resource_group" "dev" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "dev" {
  name                = "dev-vnet"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
}

resource "azurerm_subnet" "dev" {
  name                 = "dev-subnet"
  resource_group_name  = azurerm_resource_group.dev.name
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_network_interface" "dev" {
  name                = "dev-nic"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "dev" {
  name                = "dev-vm"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
  size                = "Standard_B2ms"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [azurerm_network_interface.dev.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "20h2-pro"
    version   = "latest"
  }
  tags = var.tags
}

resource "azurerm_key_vault" "dev" {
  name                        = "kv-${var.resource_group_name}"
  location                    = azurerm_resource_group.dev.location
  resource_group_name         = azurerm_resource_group.dev.name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  soft_delete_enabled         = true
  purge_protection_enabled    = true
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.dev_user_object_id
    secret_permissions = ["get", "list"]
  }
  tags = var.tags
}
