variable "settings" {
  description = "managed identity configurations"

  type = object({
    name                = string
    resource_group_name = string
    location            = string

    default_tags = optional(map(string), {
      managedBy = "terraform"
    })

    tags = optional(map(string), {
      env = "dev"
    })
  })
}
