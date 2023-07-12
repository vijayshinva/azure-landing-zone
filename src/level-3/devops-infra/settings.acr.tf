locals {
  configure_acr_resources = {
    settings = {
      location                      = "centralindia"
      resource_group_name           = "rg-test-demo"
      name                          = "simconv100"
      public_network_access_enabled = true
      data_endpoint_enabled         = true
      images_retention_enabled      = true
      images_retention_days         = 10

      georeplication_locations = [{
        location                  = "eastus"
        zone_redundancy_enabled   = true
        regional_endpoint_enabled = false
        }, {
        location                  = "northeurope"
        zone_redundancy_enabled   = true
        regional_endpoint_enabled = false
      }]
    }
  }
}
