locals {
  configure_storage_resources = {
    settings = {
      location            = "eastus"
      resource_group_name = "rg-test-demo"
      storageaccount_name = "stapppocim002"
      network_rules = {
        virtual_network_subnet_ids = ["/subscriptions/825ffda7-6684-4e20-abd1-f41592222222/resourceGroups/rg-test-demo/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/default"]
        ip_rules                   = ["49.43.243.247"]
      }
      containers = [
        {
          name = "container1"
        },
        {
          name = "container2"
        }
      ]
      file_shares = [
        {
          name        = "share1smb"
          quota_in_gb = 50
        }
      ]
      queues = [
        {
          name = "queue1"
        }
      ]
      tables = [
        {
          name = "table1"
        }
      ]
    }
  }
}
