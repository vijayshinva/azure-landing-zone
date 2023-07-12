variable "settings" {
  description = "acr Configuration."
  type = object({
    location                      = string
    resource_group_name           = string
    name                          = string
    sku                           = optional(string, "Premium")
    admin_enabled                 = optional(bool, false)
    zone_redundancy_enabled       = optional(bool, true)
    public_network_access_enabled = optional(bool,false)
    network_rule_bypass_option    = optional(bool, true)
    data_endpoint_enabled         = bool
    images_retention_enabled      = optional(bool, false)
    images_retention_days         = number
    trust_policy_enabled          = optional(bool, false)

    georeplication_locations = optional(list(object({
      location                  = string
      zone_redundancy_enabled   = bool
      regional_endpoint_enabled = bool
    })))

    network_rule_set = optional(list(object({
      default_action = optional(string)
      ip_rule = optional(list(object({
        ip_range = string
      })))
      virtual_network = optional(list(object({
        subnet_id = string
      })))
    })),null)
  })
}
