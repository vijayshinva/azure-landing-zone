variable "settings" {
  description = "Key vault configuration."
  type = object({
    azurerm_key_vault_name      = string
    location                    = string
    resource_group_name         = string
    sku_name                    = optional(string, "standard") #possible values
    purge_protection_enabled    = optional(bool, false)
    tags                        = optional(map(string), null)
    enabled_for_disk_encryption = optional(bool, true)
    network_rules = object({
      default_action             = string
      ip_rules                   = list(string)
      virtual_network_subnet_ids = list(string)
    })
  })
}
