locals {
  configure_managed_identity = {
    settings = {
      name                = "sampleua"
      resource_group_name = "rg-poc-tfmodule"
      location            = "eastus"
    }
  }
}