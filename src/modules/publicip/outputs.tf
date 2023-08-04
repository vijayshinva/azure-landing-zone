output "id" {
  value       = azurerm_public_ip.this.id
  description = "The ID of this Public IP."
  sensitive   = false
}

output "ip_address" {
  value       = azurerm_public_ip.this.ip_address
  description = " The IP address value that was allocated."
  sensitive   = false
}
