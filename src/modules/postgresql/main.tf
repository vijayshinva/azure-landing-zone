data "azurerm_client_config" "current" {}

resource "azurerm_postgresql_flexible_server" "this" {
  name                = var.settings.name
  resource_group_name = var.settings.resource_group_name
  location            = var.settings.location
  version             = var.settings.version
  delegated_subnet_id = var.settings.delegated_subnet_id
  private_dns_zone_id = var.settings.private_dns_zone_id
  zone                = var.settings.zone
  storage_mb          = var.settings.storage_mb
  sku_name            = var.settings.sku_name

  backup_retention_days        = var.settings.backup_retention_days
  geo_redundant_backup_enabled = true

  authentication {
    active_directory_auth_enabled = var.settings.authentication.active_directory_auth_enabled
    tenant_id                     = data.azurerm_client_config.current.tenant_id
    password_auth_enabled         = var.settings.authentication.password_auth_enabled
  }

  tags = merge(var.settings.default_tags, var.settings.tags)
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "this" {
  for_each         = try({ for n in var.settings.firewall_rule : n.name => n }, {})
  name             = each.key
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  for_each  = try({ for n in var.settings.azurerm_postgresql_flexible_server_database : n.name => n }, {})
  name      = each.key
  server_id = azurerm_postgresql_flexible_server.this.id
  collation = each.value.collation
  charset   = each.value.charset
}
