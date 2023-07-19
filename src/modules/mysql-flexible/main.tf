data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "this" {
  name                = "${var.settings.name}-uai"
  resource_group_name = var.settings.resource_group_name
  location            = var.settings.location
}

resource "random_password" "this" {
  length           = 32
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"
}

resource "azurerm_mysql_flexible_server" "this" {
  name                         = var.settings.name
  resource_group_name          = var.settings.resource_group_name
  location                     = var.settings.location
  version                      = var.settings.version
  delegated_subnet_id          = var.settings.delegated_subnet_id
  private_dns_zone_id          = var.settings.private_dns_zone_id
  zone                         = var.settings.zone
  sku_name                     = var.settings.sku_name
  backup_retention_days        = var.settings.backup_retention_days
  geo_redundant_backup_enabled = var.settings.geo_redundant_backup_enabled
  administrator_login          = var.settings.administrator_login
  administrator_password       = coalesce(var.settings.administrator_password, random_password.this.result )

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }

  dynamic "high_availability" {
    for_each = var.settings.high_availability != null ? [var.settings.high_availability] : []

    content {
      mode                      = high_availability.value.mode
      standby_availability_zone = high_availability.value.standby_availability_zone
    }
  }


  dynamic "storage" {
    for_each = var.settings.storage != null ? [var.settings.storage] : []

    content {
      auto_grow_enabled = storage.value.auto_grow_enabled
      iops              = storage.value.iops
      size_gb           = storage.value.size_gb
    }
  }

  tags = merge(var.settings.default_tags, var.settings.tags)

}

resource "azurerm_mysql_flexible_server_active_directory_administrator" "this" {
  server_id   = azurerm_mysql_flexible_server.this.id
  identity_id = azurerm_user_assigned_identity.this.id
  login       = "sqladmin"
  object_id   = data.azurerm_client_config.current.client_id
  tenant_id   = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_mysql_flexible_server_firewall_rule" "this" {
  for_each            = try({ for n in var.settings.firewall_rule : n.name => n }, {})
  name                = each.key
  resource_group_name = var.settings.resource_group_name
  server_name         = azurerm_mysql_flexible_server.this.name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
}

resource "azurerm_mysql_flexible_database" "this" {
  for_each            = try({ for n in var.settings.azurerm_mysql_flexible_server_database : n.name => n }, {})
  name                = each.key
  server_name         = azurerm_mysql_flexible_server.this.name
  resource_group_name = var.settings.resource_group_name
  collation           = each.value.collation
  charset             = each.value.charset
}
