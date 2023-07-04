
data "azuread_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                            = var.settings.azurerm_key_vault_name
  location                        = var.settings.location
  resource_group_name             = var.settings.resource_group_name
  enabled_for_disk_encryption     = var.settings.enabled_for_disk_encryption
  tenant_id                       = data.azuread_client_config.current.tenant_id
  soft_delete_retention_days      = 90
  purge_protection_enabled        = var.settings.purge_protection_enabled
  tags                            = var.settings.tags
  sku_name                        = var.settings.sku_name
  enabled_for_template_deployment = true
  enabled_for_deployment          = true
  enable_rbac_authorization       = true

   network_acls {
    bypass                     = "AzureServices"
    default_action             = var.settings.network_rules.default_action
    ip_rules                   = var.settings.network_rules.ip_rules
    virtual_network_subnet_ids = var.settings.network_rules.virtual_network_subnet_ids
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

locals {
  sub_id            = split("/", azurerm_key_vault.this.id)[2]
  kv_admin_role_id  = "00482a5a-887f-4fb3-b363-3b7fe8e74483" # "Key Vault Administrator" 
  key_vault_role_id = format("/subscriptions/%s/providers/Microsoft.Authorization/roleDefinitions/%s", local.sub_id, local.kv_admin_role_id)
}

resource "azurerm_role_assignment" "this" {
  scope              = azurerm_key_vault.this.id
  role_definition_id = local.key_vault_role_id
  principal_id       = data.azuread_client_config.current.object_id
}
