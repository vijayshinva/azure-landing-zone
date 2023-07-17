resource "azurerm_container_registry" "this" {
  #checkov:skip=CKV_AZURE_163:Enable vulnerability scanning for container images
  #checkov:skip=Ensure geo-replicated container registries to match multi-region container deployments

  name                          = var.settings.name
  resource_group_name           = var.settings.resource_group_name
  location                      = var.settings.location
  sku                           = var.settings.sku
  admin_enabled                 = var.settings.admin_enabled
  zone_redundancy_enabled       = var.settings.sku == "Premium" ? var.settings.zone_redundancy_enabled : null
  public_network_access_enabled = false
  network_rule_bypass_option    = var.settings.network_rule_bypass_option ? "AzureServices" : "None"
  data_endpoint_enabled         = var.settings.sku == "Premium" ? var.settings.data_endpoint_enabled : null
  quarantine_policy_enabled     = var.settings.sku == "Premium" ? true : null
  
  dynamic "retention_policy" {
    for_each = var.settings.retention_policy.enabled && var.settings.sku == "Premium" ? ["enabled"] : []

    content {
      enabled = var.settings.retention_policy.enabled
      days    = var.settings.retention_policy.days
    }
  }

  dynamic "trust_policy" {
    for_each = var.settings.trust_policy && var.settings.sku == "Premium" ? ["enabled"] : []

    content {
      enabled = var.settings.trust_policy
    }
  }

  dynamic "georeplications" {
    for_each = var.settings.georeplications != null && var.settings.sku == "Premium" ? var.settings.georeplications : []

    content {
      location                  = georeplications.value.location
      zone_redundancy_enabled   = georeplications.value.zone_redundancy_enabled
      regional_endpoint_enabled = try(georeplications.value.regional_endpoint_enabled, null)
    }
  }

  dynamic "network_rule_set" {

     for_each = var.settings.network_rule_set != null ? [var.settings.network_rule_set] : []

    content {
      default_action = lookup(network_rule_set.value, "default_action", "Allow")

      dynamic "ip_rule" {
        for_each = var.settings.network_rule_set.ip_range
        content {
          action   = "Allow"
          ip_range = ip_rule.value
        }
      }

      dynamic "virtual_network" {
        for_each = var.settings.network_rule_set.subnet_id
        content {
          action    = "Allow"
          subnet_id = virtual_network.value
        }
      }
    }
  }
}
