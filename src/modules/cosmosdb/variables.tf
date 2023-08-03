variable "settings" {
  description = "cosmosdb account configuration"

  type = object({
    name                       = string
    location                   = string
    resource_group_name        = string
    offer_type                 = optional(string, "Standard")
    kind                       = optional(string, "GlobalDocumentDB")
    analytical_storage_enabled = optional(bool, "false")

    analytical_storage = optional(object({
      schema_type = optional(string, "FullFidelity")
    }), {})

    geo_location = optional(list(object({
      location          = string
      failover_priority = number
      zone_redundant    = optional(bool, false)
    })), [])

    consistency_policy = optional(object({
      consistency_level       = optional(string, "BoundedStaleness")
      max_interval_in_seconds = optional(number, 300)
      max_staleness_prefix    = optional(number, 100000)
    }), {})

    ip_range_filter                       = optional(list(string), null)
    public_network_access_enabled         = optional(bool, false)
    is_virtual_network_filter_enabled     = optional(bool, false)
    network_acl_bypass_for_azure_services = optional(bool, false)
    network_acl_bypass_ids                = optional(list(string), null)

    virtual_network_rule = optional(list(object({
      id                                   = string
      ignore_missing_vnet_service_endpoint = bool
    })), [])

    backup = optional(object({
      type                = optional(string, "Periodic")
      interval_in_minutes = optional(number, 3 * 60)
      retention_in_hours  = optional(number, 7 * 24)
    }), {})

    identity = optional(object({
      type = optional(string, "SystemAssigned")
    }), {})

    tags = optional(map(string), {
      managedBy = "terraform"
    })
  })
}
