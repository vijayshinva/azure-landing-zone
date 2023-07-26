locals {
  configure_mssql_resources = {
    settings = {
      location            = "westus"
      resource_group_name = "rg-poc-tfmodule"
      name                = "mssqlimxyzserver"

      elasticpool = {
        name = "mssqlimxyzserver"

        per_database_settings = {
        }

        sku = {
        }
      }

      virtual_network_rule = [
        {
          name      = "vnetrule1"
          subnet_id = "/subscriptions/5cb3db32-a59f-4aa5-9378-623c75ee0d8dddddddd/resourceGroups/rg-poc-tfmodule/providers/Microsoft.Network/virtualNetworks/demo-vnet1/subnets/mysql"
        }
      ]

      mssql_database = [
        {
          name        = "db1"
          max_size_gb = 10
          }, {
          name        = "db3"
          max_size_gb = 10
        }
      ]

      tags = {
        costcenter = "001007"
        env        = "dev"
      }
    }
  }
}
