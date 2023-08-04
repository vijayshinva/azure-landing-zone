resource "azurerm_public_ip" "this" {
  name                    = var.settings.name
  location                = var.settings.location
  resource_group_name     = var.settings.resource_group_name
  allocation_method       = var.settings.allocation_method
  zones                   = var.settings.zones
  sku                     = var.settings.sku
  ddos_protection_mode    = var.settings.ddos_protection_mode
  ddos_protection_plan_id = var.settings.ddos_protection_plan_id
  tags                    = merge(var.settings.default_tags, var.settings.tags)
}
