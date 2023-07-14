variable "settings" {
  description = "configure acr resources"
  type = object({
    location                   = string
    resource_group_name        = string
    name                       = string
    sku                        = optional(string, "Standard")
    admin_enabled              = optional(bool, false)
    zone_redundancy_enabled    = optional(bool, true)
    network_rule_bypass_option = optional(bool, true)
    data_endpoint_enabled      = bool

    retention_policy = object({
      enabled = optional(bool, false)
      days    = optional(number, 7)
    })

    trust_policy = optional(bool, true)

    georeplications = list(object({
      location                  = string
      zone_redundancy_enabled   = bool
      regional_endpoint_enabled = bool
    }))

    network_rule_set = object({
      default_action = optional(string)
      ip_range       = optional(list(string), [])
      subnet_id      = optional(list(string), [])
    })

  })
}
