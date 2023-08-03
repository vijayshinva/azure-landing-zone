locals {
  configure_cosmosdb_resources = {
    settings = {
      location            = "westus"
      resource_group_name = "rg-poc-tfmodule"
      name                = "cosmosdbtfmodule123"


      geo_location = [
        {
          location          = "eastus"
          failover_priority = 1
          }, {
          location          = "eastus2"
          failover_priority = 0
        }
      ]
    }
  }
}
