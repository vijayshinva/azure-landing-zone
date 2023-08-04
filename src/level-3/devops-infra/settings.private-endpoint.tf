locals {
  configure_private-endpoint_resources = {
    settings = {
      private_endpoint = [{
        name                            = "endpoint1"
        location                        = "eastus"
        resource_group_name             = "rg-poc-tfmodule"
        subnet_id                       = "/subscriptions/5cb3db32-a59ffsdf-4aa5-9378-623c75ee0d8d/resourceGroups/rg-poc-tfmodule/providers/Microsoft.Network/virtualNetworks/demo-vnet1/subnets/default"
        private_service_connection_name = "one1asdaSD"
        private_connection_resource_id  = "/subscriptions/5cb3db32-a59ffsdfsd-4aa5-9378-623c75ee0d8d/resourceGroups/rg-tf/providers/Microsoft.Storage/storageAccounts/tfstatecafpoc1/blobServices/default"
        tags = {
          costcenter = "001007"
          env        = "dev"
        }
        }, {
        name                            = "endpoint2"
        location                        = "eastus"
        resource_group_name             = "rg-poc-tfmodule"
        subnet_id                       = "/subscriptions/5cb3db32-a59f-4aa5sdfsdf-9378-623c75ee0d8d/resourceGroups/rg-poc-tfmodule/providers/Microsoft.Network/virtualNetworks/demo-vnet1/subnets/default"
        private_service_connection_name = "one2ASDAdas"
        private_connection_resource_id  = "/subscriptions/5cb3db32-a59ffsdf-4aa5-9378-623c75ee0d8d/resourceGroups/rg-tf/providers/Microsoft.Storage/storageAccounts/tfstatecafpoc1/fileServices/default"
        },
        {
          name                            = "endpoint3"
          location                        = "eastus"
          resource_group_name             = "rg-poc-tfmodule"
          subnet_id                       = "/subscriptions/5cb3db32-a59ffsdfsdf-4aa5-9378-623c75ee0d8d/resourceGroups/rg-poc-tfmodule/providers/Microsoft.Network/virtualNetworks/demo-vnet1/subnets/default"
          private_service_connection_name = "one3ASDAdas"
          private_connection_resource_id  = "/subscriptions/5cb3db32-a59ffsdfsdfsdf-4aa5-9378-623c75ee0d8d/resourceGroups/rg-tf/providers/Microsoft.Storage/storageAccounts/tfstatecafpoc1/queueServices/default"
      }]
    }
  }
}
