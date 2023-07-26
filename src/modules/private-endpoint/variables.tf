variable "settings" {
  description = "mssql configuration"

  type = object({
    private_endpoint = list(object({
      name                = string
      location            = string
      resource_group_name = string
      subnet_id           = string
      is_manual_connection = optional(bool, false)
      private_service_connection_name = string
      private_connection_resource_id = string
      tags                = optional(map(string), {})
    }))

    default_tags = optional(map(string), {
      managedBy = "terraform"
    })

  })
}
