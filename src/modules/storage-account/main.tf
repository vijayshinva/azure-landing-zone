resource "azurerm_storage_account" "this" {
  #checkov:skip=CKV2_AZURE_1:Ensure storage for critical data are encrypted with Customer Managed Key
  #checkov:skip=CKV_AZURE_206:Ensure that Storage Accounts use replication
  name                            = var.settings.storageaccount_name
  resource_group_name             = var.settings.resource_group_name
  location                        = var.settings.location
  account_kind                    = var.settings.account_kind
  account_tier                    = var.settings.account_tier
  account_replication_type        = var.settings.account_replication_type
  allow_nested_items_to_be_public = false
  edge_zone                       = var.settings.edge_zone
  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = var.settings.shared_access_key_enabled
  tags                            = var.settings.tags
  large_file_share_enabled        = var.settings.large_file_share_enabled
  nfsv3_enabled                   = var.settings.nfsv3_enabled
  public_network_access_enabled   = false
  blob_properties {
    container_delete_retention_policy {
      days = 7
    }
  }
}

resource "azurerm_storage_account_network_rules" "this" {
  storage_account_id         = azurerm_storage_account.this.id
  virtual_network_subnet_ids = var.settings.network_rules.virtual_network_subnet_ids
  default_action             = "Deny"
  bypass                     = ["AzureServices"]
  ip_rules                   = var.settings.network_rules.ip_rules
}

resource "azurerm_storage_container" "this" {
  #checkov:skip=CKV2_AZURE_21:Ensure Storage logging is enabled for Blob service for read requests
  for_each              = try({ for c in var.settings.containers : c.name => c }, {})
  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
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
  #checkov:skip=CKV2_AZURE_20:Ensure Storage logging is enabled for Table service for read requests
  for_each             = try({ for t in var.settings.tables : t.name => t }, {})
  name                 = each.key
  storage_account_name = azurerm_storage_account.this.name
}
