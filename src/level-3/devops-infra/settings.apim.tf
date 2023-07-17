locals {
  configure_apim_resources = {
    settings = {
      name                = "testapize"
      resource_group_name = "rg-test-demo"
      location            = "australiaeast"
      publisher_name      = "test"
      publisher_email     = "test@gmail.com"
      sku_name            = "Developer_1"
      key_vault_secret_id = data.azurerm_key_vault_certificate.this.secret_id
      certificate_name    = "example-cert"
    }
  }
}
