provider "azurerm" {
  features {}
}
module "dev_env" {
  source              = "./modules/dev_env"
  resource_group_name = var.resource_group_name
  location            = var.location
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  tenant_id           = var.tenant_id
  dev_user_object_id  = var.dev_user_object_id
  tags                = var.tags
}
