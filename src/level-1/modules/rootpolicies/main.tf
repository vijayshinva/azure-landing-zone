# Configure Terraform to set the required AzureRM provider
# version and features{} block

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.54.0"
    }
  }
}

# Define the provider configuration

provider "azurerm" {
  features {
  }
}

# Get the current client configuration from the AzureRM provider
data "azurerm_client_config" "current" {}

locals {
  template_vars = {
    management_group_id = var.management_group_id,
    default_location    = var.primary_location,
    primary_location    = var.primary_location,
    secondary_location  = var.secondary_location
  }
}

# Policy Definitions
resource "azurerm_policy_definition" "policy" {
  for_each = local.policy_definitions_map_from_json

  name                = each.value.name
  policy_type         = each.value.properties.policyType
  mode                = each.value.properties.mode
  display_name        = each.value.properties.displayName
  description         = each.value.properties.description
  management_group_id = var.management_group_id
  metadata            = jsonencode(each.value.properties.metadata)
  parameters          = jsonencode(each.value.properties.parameters)
  policy_rule         = jsonencode(each.value.properties.policyRule)
}


# Policy Assignments
resource "azurerm_management_group_policy_assignment" "this" {
  depends_on = [
    azurerm_policy_definition.policy
  ]

  for_each = local.policy_assignments_map_from_json

  name                 = each.value.name
  policy_definition_id = each.value.properties.policyDefinitionId
  management_group_id  = each.value.properties.scope
  description          = each.value.properties.description
  display_name         = each.value.properties.displayName
  parameters           = jsonencode(each.value.properties.parameters)
  enforce = coalesce(
    try(lower(each.value.properties.enforcementMode) == "default", false) ? true : null,
    try(lower(each.value.properties.enforcementMode) == "donotenforce", false) ? false : null,
    true,
  )
}
