locals {
  configure_keyvault_resources = {
    settings = {
      resource_group_name    = "testRG"
      azurerm_key_vault_name = "keyvaultnameze"
      location               = "australiaeast"
      network_rules = {
        default_action             = "Deny"
        ip_rules                   = ["192.168.97.0"]
        virtual_network_subnet_ids = []
      }
    }
  }
}
