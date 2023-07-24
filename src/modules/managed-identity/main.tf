resource "azurerm_user_assigned_identity" "this" {
  name                = "${var.settings.name}-uai"
  resource_group_name = var.settings.resource_group_name
  location            = var.settings.location

  tags = merge(var.settings.default_tags, var.settings.tags)
}
