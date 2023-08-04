locals {
  configure_bastion_resources = {
    settings = {
      name                = "bastionhost"
      location            = "eastus"
      resource_group_name = "rg-poc-tfmodule"

      ip_configuration = {
        name      = "myconfig"
        subnet_id = "/subscriptions/5cb3db32-a59f-4aa5-9378-623c75ee0d8d/resourceGroups/rg-poc-tfmodule/providers/Microsoft.Network/virtualNetworks/demo-vnet1/subnets/postgres"
      }
    }
  }
}
