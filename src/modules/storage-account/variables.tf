# variable "enable_https_traffic_only" {
#   type = bool
#   default = true
# }
variable "settings" {
  description = "Storage account configurations"
  type = object({
    storageaccount_name             = string
    location                        = string
    resource_group_name             = string
    account_kind                    = optional(string, "StorageV2")
    account_tier                    = optional(string, "Standard")
    account_replication_type        = optional(string, "GRS")
    allow_nested_items_to_be_public = optional(bool, false)
    edge_zone                       = optional(string, null)
    enable_https_traffic_only       = bool
    min_tls_version                 = optional(string, "TLS1_2")
    shared_access_key_enabled       = optional(bool, true)
    large_file_share_enabled        = optional(bool, false)
    nfsv3_enabled                   = optional(bool, false)
    tags                            = optional(map(string), null)

    network_rules = object({
      default_action             = optional(string, "Deny")
      bypass                     = optional(list(string),["AzureServices"])
      virtual_network_subnet_ids = list(string)
      ip_rules                   = list(string)
    })

    containers = list(object({
      name                  = string
      container_access_type = optional(string, "private")
    }))

    file_shares = list(object({
      name             = string
      quota_in_gb      = optional(number, 50)
      enabled_protocol = optional(string)
      metadata         = optional(map(string))
      acl = optional(list(object({
        id          = string
        permissions = string
        start       = optional(string)
        expiry      = optional(string)
      })))
    }))

    queues = list(object({
      name = string
    }))

    tables = list(object({
      name = string
    }))
  })
}
