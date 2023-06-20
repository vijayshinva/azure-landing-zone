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
  features {}
}

# Get the current client configuration from the AzureRM provider

data "azurerm_client_config" "current" {}

# Declare the Azure landing zones Terraform module
# and provide the landing zone configuration

module "caf-enterprise-scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = ">= 4.0.0"

  default_location = var.primary_location

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  # Base module configuration settings
  root_parent_id = data.azurerm_client_config.current.tenant_id
  root_id        = var.root_id
  root_name      = var.root_name
  library_path   = "${path.module}/lib"

  # Disable creation of the core management group hierarchy
  # as this is being created by the core module instance
  deploy_core_landing_zones = false

  # Configuration settings for landing zones is in settings.landingzones
  custom_landing_zones = local.custom_landing_zones
}


# Enterprise scale nested landing zone instance

module "enterprise_scale_nested_landing_zone" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = ">= 4.0.0" 

  default_location = var.primary_location

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  root_parent_id            = "zee5-Zee5"
  root_id                   = var.root_id
  deploy_core_landing_zones = false
  library_path              = "${path.root}/lib"

  custom_landing_zones = {
    "${var.root_id}-Zee5-nonprod" = {
      display_name               = "${upper(var.root_id)} nonprod"
      parent_management_group_id = "zee5-Zee5"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }

    "${var.root_id}-Zee5-prod" = {
      display_name               = "${upper(var.root_id)} prod"
      parent_management_group_id = "zee5-Zee5"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }
  }


  

  depends_on = [
    module.caf-enterprise-scale,
  ]

}


# Enterprise scale nested landing zone instance

module "enterprise_scale_nested_landing_zone_zee_entertainment" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = ">= 4.0.0" 

  default_location = var.primary_location

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  root_parent_id            = "zee5-zee-entertainment"
  root_id                   = var.root_id
  deploy_core_landing_zones = false
  library_path              = "${path.root}/lib"

  custom_landing_zones = {
    "${var.root_id}-zee-entertainment-nonprod" = {
      display_name               = "${upper(var.root_id)} nonprod"
      parent_management_group_id = "zee5-zee-entertainment"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }

    "${var.root_id}-zee-entertainment-prod" = {
      display_name               = "${upper(var.root_id)} prod"
      parent_management_group_id = "zee5-zee-entertainment"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }
  }

  depends_on = [
    module.caf-enterprise-scale,
  ]

}

