resource "azurerm_user_assigned_identity" "this" {
  name                = "${var.settings.name}-UAT1"
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
}

locals {
  configure_managed_identity = {
    settings = {
      name                = var.settings.name
      resource_group_name = var.settings.resource_group_name
      location            = var.settings.location
    }
  }
}

module "managed-identity" {
  source   = "../managed-identity"
  settings = local.configure_managed_identity.settings
}

resource "azurerm_mssql_server" "this" {
  name                                 = var.settings.name
  resource_group_name                  = var.settings.resource_group_name
  location                             = var.settings.location
  version                              = var.settings.version
  connection_policy                    = var.settings.connection_policy
  minimum_tls_version                  = "1.2"
  public_network_access_enabled        = false
  outbound_network_restriction_enabled = false

  azuread_administrator {
    login_username              = module.managed-identity.name
    object_id                   = module.managed-identity.principal_id
    azuread_authentication_only = true
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(var.settings.default_tags, var.settings.tags)

  depends_on = [azurerm_user_assigned_identity.this]
}

resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  server_id         = azurerm_mssql_server.this.id
  retention_in_days = 91
}

resource "azurerm_mssql_elasticpool" "this" {
  name                = var.settings.elasticpool.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  license_type        = try(var.settings.elasticpool.license_type, null)
  server_name         = azurerm_mssql_server.this.name
  max_size_gb         = try(var.settings.elasticpool.max_size_gb, null)
  max_size_bytes      = try(var.settings.max_size_bytes, null)

  per_database_settings {
    max_capacity = var.settings.elasticpool.per_database_settings.max_capacity
    min_capacity = var.settings.elasticpool.per_database_settings.min_capacity
  }

  sku {
    capacity = var.settings.elasticpool.sku.capacity
    name     = var.settings.elasticpool.sku.name
    tier     = var.settings.elasticpool.sku.tier
    family   = try(var.settings.elasticpool.sku.family, null)
  }

  tags = merge(var.settings.default_tags, var.settings.tags)
}

resource "azurerm_mssql_virtual_network_rule" "this" {
  for_each  = try({ for subnet in var.settings.virtual_network_rule.subnet_id : subnet.name => subnet }, {})
  name      = each.key
  server_id = azurerm_mssql_server.this.id
  subnet_id = each.value.subnet_id
}

resource "azurerm_mssql_database" "this" {
  for_each        = try({ for n in var.settings.mssql_database.name : n.name => n }, {})
  name            = each.key
  server_id       = azurerm_mssql_server.this.id
  elastic_pool_id = azurerm_mssql_elasticpool.this.id
  collation       = each.value.collation
  license_type    = each.value.license_type
  max_size_gb     = each.value.max_size_gb
  read_scale      = each.value.read_scale
  sku_name        = each.value.sku_name
  zone_redundant  = true

  tags = merge(var.settings.default_tags, var.settings.tags)
}
