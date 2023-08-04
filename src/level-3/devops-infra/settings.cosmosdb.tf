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

      virtual_network_rule = [{
        id = "/subscriptions/5cb3db32-a59f-4aa5-9378-623c75ee0d8dddddddd/resourceGroups/rg-poc-tfmodule/providers/Microsoft.Network/virtualNetworks/demo-vnet1/subnets/cosmosdb"
        }
      ]
    }
  }
}
