resource "azurerm_container_registry" "this" {
  name                          = var.settings.name
  resource_group_name           = var.settings.resource_group_name
  location                      = var.settings.location
  sku                           = var.settings.sku
  admin_enabled                 = var.settings.admin_enabled
  zone_redundancy_enabled       = var.settings.zone_redundancy_enabled
  public_network_access_enabled = var.settings.public_network_access_enabled
  network_rule_bypass_option    = var.settings.network_rule_bypass_option ? "AzureServices" : "None"
  data_endpoint_enabled         = var.settings.data_endpoint_enabled

  dynamic "retention_policy" {
    for_each = var.settings.images_retention_enabled && var.settings.sku == "Premium" ? ["enabled"] : []

    content {
      enabled = var.settings.images_retention_enabled
      days    = var.settings.images_retention_days
    }
  }

  dynamic "trust_policy" {
    for_each = var.settings.trust_policy_enabled && var.settings.sku == "Premium" ? ["enabled"] : []

    content {
      enabled = var.settings.trust_policy_enabled
    }
  }

  dynamic "georeplications" {
    for_each = var.settings.georeplication_locations

    content {
      location                  = georeplications.value.location
      zone_redundancy_enabled   = try(georeplications.value.zone_redundancy_enabled, null)
      regional_endpoint_enabled = try(georeplications.value.regional_endpoint_enabled, null)
    }
  }

  dynamic "network_rule_set" {
    for_each = var.settings.network_rule_set != null ? [var.settings.network_rule_set] : []

    content {
       default_action = lookup(network_rule_set.value, "default_action", "Allow")

      dynamic "ip_rule" {
        for_each = network_rule_set.value.ip_rule
        content {
          action   = "Allow"
          ip_range = ip_rule.value.ip_range
        }
      }

      dynamic "virtual_network" {
        for_each = network_rule_set.value.virtual_network
        content {
          action    = "Allow"
          subnet_id = virtual_network.value.subnet_id
        }
      }
    }
  }
}
