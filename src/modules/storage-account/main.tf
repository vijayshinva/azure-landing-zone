resource "azurerm_storage_account" "this" {
  name                            = var.settings.storageaccount_name
  resource_group_name             = var.settings.resource_group_name
  location                        = var.settings.location
  account_kind                    = var.settings.account_kind
  account_tier                    = var.settings.account_tier
  account_replication_type        = var.settings.account_replication_type
  allow_nested_items_to_be_public = var.settings.allow_nested_items_to_be_public
  edge_zone                       = var.settings.edge_zone
  enable_https_traffic_only       = var.settings.enable_https_traffic_only
  min_tls_version                 = var.settings.min_tls_version
  shared_access_key_enabled       = var.settings.shared_access_key_enabled
  tags                            = var.settings.tags
  large_file_share_enabled        = var.settings.large_file_share_enabled
  nfsv3_enabled                   = var.settings.nfsv3_enabled
}

resource "azurerm_storage_account_network_rules" "this" {
  storage_account_id         = azurerm_storage_account.this.id
  virtual_network_subnet_ids = var.settings.network_rules.virtual_network_subnet_ids
  default_action             = var.settings.network_rules.default_action
  bypass                     = var.settings.network_rules.bypass
  ip_rules                   = var.settings.network_rules.ip_rules
}

resource "azurerm_storage_container" "this" {

  for_each              = try({ for c in var.settings.containers : c.name => c }, {})
  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = each.value.container_access_type
}

resource "azurerm_storage_share" "this" {
  for_each             = try({ for s in var.settings.file_shares : s.name => s }, {})
  name                 = each.key
  storage_account_name = azurerm_storage_account.this.name
  quota                = each.value.quota_in_gb
  enabled_protocol     = each.value.enabled_protocol
  metadata             = each.value.metadata

  dynamic "acl" {
    for_each = each.value.acl != null ? each.value.acl : []

    content {
      id = acl.value.id

      access_policy {
        permissions = acl.value.permissions
        start       = acl.value.start
        expiry      = acl.value.expiry
      }
    }
  }
}

resource "azurerm_storage_queue" "this" {
  for_each             = try({ for q in var.settings.queues : q.name => q }, {})
  name                 = each.key
  storage_account_name = azurerm_storage_account.this.name
}

resource "azurerm_storage_table" "this" {
  for_each             = try({ for t in var.settings.tables : t.name => t }, {})
  name                 = each.key
  storage_account_name = azurerm_storage_account.this.name
}
