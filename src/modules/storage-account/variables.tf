variable "settings" {
  description = "Storage account configurations"
  type = object({
    storageaccount_name             = string
    location                        = string
    resource_group_name             = string
    account_kind                    = optional(string, "StorageV2")
    account_tier                    = optional(string, "Standard")
    account_replication_type        = optional(string, "GRS")
    edge_zone                       = optional(string, null)
    shared_access_key_enabled       = optional(bool, true)
    large_file_share_enabled        = optional(bool, false)
    nfsv3_enabled                   = optional(bool, false)
    tags                            = optional(map(string), null)

    network_rules = object({
      virtual_network_subnet_ids = list(string)
      ip_rules                   = list(string)
    })

    containers = optional(list(object({
      name                  = string
    })))

    file_shares = optional(list(object({
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
    })))

    queues = optional(list(object({
      name = string
    })))

    tables = optional(list(object({
      name = string
    })))
  })
}
