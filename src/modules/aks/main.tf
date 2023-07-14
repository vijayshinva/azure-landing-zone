resource "azurerm_kubernetes_cluster" "this" {
  #checkov:skip=CKV_AZURE_4:Ensure AKS logging to Azure Monitoring is Configured
  #checkov:skip=CKV_AZURE_170:Ensure that AKS use the Paid Sku for its SLA
  name                          = var.settings.name
  location                      = var.settings.location
  resource_group_name           = var.settings.resource_group_name
  dns_prefix                    = var.settings.name
  kubernetes_version            = var.settings.kubernetes_version
  sku_tier                      = var.settings.sku_tier
  node_resource_group           = var.settings.node_resource_group
  private_cluster_enabled       = var.settings.private_cluster_enabled
  private_dns_zone_id           = var.settings.private_cluster_enabled ? var.settings.private_dns_zone_id : null
  azure_policy_enabled          = var.settings.azure_policy_enabled
  public_network_access_enabled = var.settings.public_network_access_enabled
  local_account_disabled        = var.settings.local_account_disabled

  dynamic "key_vault_secrets_provider" {
     for_each = var.settings.key_vault_secrets_provider.secret_rotation_enabled == true ? [1] : []
    content {
      secret_rotation_enabled  = var.settings.key_vault_secrets_provider.secret_rotation_enabled
      secret_rotation_interval = var.settings.key_vault_secrets_provider.secret_rotation_interval
    }
  }
  default_node_pool {
    name                  = var.settings.default_node_pool.name
    node_count            = var.settings.default_node_pool.node_count
    vm_size               = var.settings.default_node_pool.vm_size
    enable_auto_scaling   = var.settings.default_node_pool.enable_auto_scaling
    enable_node_public_ip = var.settings.default_node_pool.enable_node_public_ip
    vnet_subnet_id        = var.settings.default_node_pool.vnet_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = var.settings.network_profile.load_balancer_sku
    service_cidr      = var.settings.network_profile.service_cidr
    dns_service_ip    = var.settings.network_profile.dns_service_ip
  }

  azure_active_directory_role_based_access_control {
    managed            = var.settings.azure_active_directory_role_based_access_control.managed
    azure_rbac_enabled = var.settings.azure_active_directory_role_based_access_control.azure_rbac_enabled
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "this" {
  for_each = try({ for np in var.settings.azurerm_kubernetes_cluster_node_pool : np.name => np }, {})

  kubernetes_cluster_id  = azurerm_kubernetes_cluster.this.id
  name                   = each.key
  vm_size                = each.value.vm_size
  os_type                = each.value.os_type
  os_disk_type           = each.value.os_disk_type
  os_disk_size_gb        = each.value.os_disk_size_gb
  priority               = each.value.priority
  vnet_subnet_id         = each.value.vnet_subnet_id
  enable_host_encryption = each.value.enable_host_encryption
  eviction_policy        = each.value.eviction_policy
  enable_auto_scaling    = each.value.enable_auto_scaling
  node_count             = each.value.node_count
  min_count              = each.value.enable_auto_scaling ? each.value.min_count : null
  max_count              = each.value.enable_auto_scaling ? var.settings.azurerm_kubernetes_cluster_node_pool.max_count : null
  max_pods               = each.value.max_pods
  node_labels            = each.value.node_labels
  node_taints            = each.value.node_taints
  enable_node_public_ip  = each.value.enable_node_public_ip
  zones                  = each.value.zones
  tags                   = each.value.tag
}

