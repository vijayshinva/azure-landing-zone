locals {
  configure_aks_resources = {
    settings = {
      location                                         = "eastus"
      resource_group_name                              = "rg-test-demo"
      name                                             = "aks-poc-centralind-001"
      kubernetes_version                               = "1.25.6"
      sku_tier                                         = "Free"
      private_cluster_enabled                          = true
      azure_active_directory_role_based_access_control = {}
      default_node_pool = {
        node_count     = 1
        vm_size        = "Standard_D2_v2"
        vnet_subnet_id = "/subscriptions/825ffda7-6684-4e20-abd1-f41592222222/resourceGroups/rg-test-demo/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/default"
      }

      network_profile = {
        service_cidr   = "11.0.0.0/16"
        dns_service_ip = "11.0.0.10"
      }

      azurerm_kubernetes_cluster_node_pool = [{
        name           = "aksnp001"
        vm_size        = "Standard_DS2_v2"
        node_count     = 1
        vnet_subnet_id = "/subscriptions/825ffda7-6684-4e20-abd1-f41592222222/resourceGroups/rg-test-demo/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/default"
        }, {
        name           = "aksnp002"
        vm_size        = "Standard_DS2_v2"
        node_count     = 2
        vnet_subnet_id = "/subscriptions/825ffda7-6684-4e20-abd1-f41592222222/resourceGroups/rg-test-demo/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/default"
        }, {
        name           = "aksnp003"
        vm_size        = "Standard_DS2_v2"
        node_count     = 1
        vnet_subnet_id = "/subscriptions/825ffda7-6684-4e20-abd1-f41592222222/resourceGroups/rg-test-demo/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/default"
      }]
    }
  }
}
