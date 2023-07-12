locals {
  configure_keyvault_resources = {
    settings = {
      resource_group_name    = "rg-test-demo"
      azurerm_key_vault_name = "keyvaultnameze1"
      location               = "australiaeast"
      network_rules = {
        default_action             = "Deny"
        ip_rules                   = ["49.37.250.139"]
        virtual_network_subnet_ids = []
      }
    }
  }
}
