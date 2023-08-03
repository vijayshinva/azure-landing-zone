output "id" {
  value       = azurerm_cosmosdb_account.this.id
  description = "The CosmosDB Account ID."
}

output "endpoint" {
  value       = azurerm_cosmosdb_account.this.endpoint
  description = "The endpoint used to connect to the CosmosDB account."
}

output "read_endpoints" {
  value       = azurerm_cosmosdb_account.this.read_endpoints
  description = " A list of read endpoints available for this CosmosDB account."
}

output "read_endpoints" {
  value       = azurerm_cosmosdb_account.this.read_endpoints
  description = " A list of read endpoints available for this CosmosDB account."
}
