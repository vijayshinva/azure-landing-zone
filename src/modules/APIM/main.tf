resource "azurerm_api_management" "this" {
  name                          = var.settings.name
  location                      = var.settings.location
  resource_group_name           = var.settings.resource_group_name
  publisher_name                = var.settings.publisher_name
  publisher_email               = var.settings.publisher_email
  sku_name                      = var.settings.sku_name
  public_network_access_enabled = var.settings.public_network_access_enabled
  virtual_network_type          = var.settings.virtual_network_type

  dynamic "virtual_network_configuration" {
    for_each = var.settings.virtual_network_type == "Internal" ? [1] : []
    content {
      subnet_id = var.settings.subnet_id
    }
  }

  identity {
    type         = var.settings.identity_type
    identity_ids = replace(var.settings.identity_type, "UserAssigned", "") == var.settings.identity_type ? null : var.settings.identity_ids
  }
}

resource "azurerm_api_management_policy" "this" {
  for_each = var.settings.policy_file_name

  api_management_id = azurerm_api_management.this.id
  xml_content       = file("${path.module}/Policy/${each.key}.xml")
}

resource "azurerm_api_management_certificate" "this" {
  name                = var.settings.certificate_name
  api_management_name = azurerm_api_management.this.name
  resource_group_name = var.settings.resource_group_name
  key_vault_secret_id = var.settings.key_vault_secret_id
}
