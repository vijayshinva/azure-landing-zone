locals {
  configure_postgres_resources = {
    settings = {
      location            = "eastus"
      resource_group_name = "rg-poc-tfmodule"
      name                = "postgressimxyzserver"
      delegated_subnet_id = "/subscriptions/5cb3db32-a59f-4aa5-9378-623c75ee0d8d/resourceGroups/rg-poc-tfmodule/providers/Microsoft.Network/virtualNetworks/demo-vnet1/subnets/postgres"
      private_dns_zone_id = "/subscriptions/5cb3db32-a59f-4aa5-9378-623c75ee0d8d/resourceGroups/rg-poc-tfmodule/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com"

      authentication = {
        active_directory_auth_enabled = true
        password_auth_enabled         = false
      }

      firewall_rule = [
        {
          name             = "rule1"
          start_ip_address = "122.122.0.0"
          end_ip_address   = "122.122.0.0"
        },
        {
          name             = "rule2"
          start_ip_address = "123.122.0.0"
          end_ip_address   = "123.122.0.0"
        }
      ]
      azurerm_postgresql_flexible_server_database = [
        {
          name = "db1"
          }, {
          name = "db2"
        }
      ]

      tags = {
        costcenter = "001007"
        createdat = timestamp()
      }
    }
  }
}
