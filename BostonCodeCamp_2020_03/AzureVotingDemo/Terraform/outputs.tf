output "kube_config" {
  value = "${module.aks.kube_config_raw}"
}
output "nginx_ingress_fqdn" {
  value = "${module.aks.nginx_ingress_fqdn}"
}
