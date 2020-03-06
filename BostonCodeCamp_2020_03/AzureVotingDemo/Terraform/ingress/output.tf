output "k8s_ns_name"{
  value = "${kubernetes_namespace.app_ns.metadata.0.name}"
}