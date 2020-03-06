output "id" {
  value = "${azurerm_kubernetes_cluster.aks.id}"
}
output "kube_config_raw" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config_raw}"
}
output "kube_config" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config}"
}
output "client_key" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.client_key}"
}
output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate}"
}
output "cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate}"
}
output "host" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.host}"
}
output "node_resource_group" {
  value = "${azurerm_kubernetes_cluster.aks.node_resource_group}"
}
output "nginx_ingress_fqdn" {
  value = "${azurerm_public_ip.nginx_ingress.fqdn}"
}
output "ingress_ip"{
  value = "${azurerm_public_ip.nginx_ingress.ip_address}"
}
output "fqdn"{
  value = "${azurerm_public_ip.nginx_ingress.fqdn}"
}
output "docker_config_json"{
  value = "${data.azurerm_key_vault_secret.registry-dockerconfig.value}"
}
