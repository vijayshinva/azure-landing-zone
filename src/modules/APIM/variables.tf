variable "settings" {
  description = "APIM configuration."
  type = object({
    name                          = string
    location                      = string
    resource_group_name           = string
    publisher_name                = string
    publisher_email               = string
    sku_name                      = string
    public_network_access_enabled = optional(bool, true)
    virtual_network_type          = optional(string, "None")
    subnet_id                     = optional(string, null)
    identity_ids                  = optional(list(string), null)
    identity_type                 = optional(string, "SystemAssigned")
    policy_file_name              = optional(set(string), ["test"])
    key_vault_secret_id           = optional(string)
    certificate_name              = optional(string)
  })
}
