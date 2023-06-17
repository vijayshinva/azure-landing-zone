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

# The following module declarations act to orchestrate the
# independently defined module instances for core,
# connectivity and management resources

module "landingzones" {
  source = "./modules/landingzones"

  root_id   = var.root_id
  root_name = var.root_name
  primary_location = 
}
