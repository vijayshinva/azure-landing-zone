output "client_certificate" {
  description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.this.kube_config.0.client_certificate
  sensitive   = true
}

output "kube_config" {
  description = "Raw Kubernetes config to be used by kubectl and other compatible tools."
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "aks_id" {
  description = "The Kubernetes Managed Cluster ID."
  value       = azurerm_kubernetes_cluster.this.id
}

output "aks_nodes_pools_ids" {
  description = "Ids of AKS nodes pools"
  value       = [for i in azurerm_kubernetes_cluster_node_pool.this : i.id]
}

output "kube_identity" {
  description = "Object Id of managed identity"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}
