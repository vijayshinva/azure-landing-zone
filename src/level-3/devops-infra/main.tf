provider "azurerm" {
  features {}
}

data "azuread_client_config" "current" {}

module "Key_Vault" {
  source = "./modules/Key-Vault"
  settings  = local.configure_keyvault_resources.settings
}
