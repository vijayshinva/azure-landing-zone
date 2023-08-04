resource "azurerm_private_endpoint" "this" {
  for_each            = try({ for n in var.settings.private_endpoint : n.name => n }, {})
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = each.value.subnet_id
  tags                = merge(var.settings.default_tags, each.value.tags)

  private_service_connection {
    name                           = "${each.value.private_service_connection_name}-connection"
    is_manual_connection           = each.value.is_manual_connection
    private_connection_resource_id = each.value.private_connection_resource_id
  }
}
