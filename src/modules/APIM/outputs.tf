output "id" {
  description = "The ID of the API Management Service."
  value       = azurerm_api_management.this.id
}

output "gateway_url" {
  description = "The URL of the Gateway for the API Management Service."
  value       = azurerm_api_management.this.gateway_url
}

output "management_api_url" {
  description = "The URL for the Management API associated with this API Management service."
  value       = azurerm_api_management.this.management_api_url
}
