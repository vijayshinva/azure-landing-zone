provider "azurerm" {
  features {}
}

data "azuread_client_config" "current" {}

module "Key_Vault" {
  source   = "../../modules/Key-Vault"
  settings = local.configure_keyvault_resources.settings
}

data "azurerm_key_vault_certificate" "this" {
  name         = "test1"
  key_vault_id = module.Key_Vault.id
}

module "apim" {
  source   = "../../modules/APIM"
  settings = local.configure_apim_resources.settings
}

module "acr" {
  source   = "../../modules/acr"
  settings = local.configure_acr_resources.settings
}

module "aks" {
  source   = "../../modules/aks"
  settings = local.configure_aks_resources.settings
}

module "storage_account" {
  source   = "../../modules/storage-account"
  settings = local.configure_storage_resources.settings
}

module "postgres_flexible" {
  source   = "../../modules/postgresql"
  settings = local.configure_postgres_resources.settings
}

module "mysql_flexible" {
  source   = "../../modules/mysql-flexible"
  settings = local.configure_mysql_resources.settings
}

module "mssql" {
  source   = "../../modules/mssql"
  settings = local.configure_mssql_resources.settings
}

module "managed-identity" {
  source   = "../managed-identity"
  settings = local.configure_managed_identity.settings
}

module "private-endpoint" {
  source   = "../private-endpoint"
  settings = local.configure_private-endpoint_resources.settings
}

module "bastion" {
  source   = "../bastion"
  settings = local.configure_bastion_resources.settings
}
