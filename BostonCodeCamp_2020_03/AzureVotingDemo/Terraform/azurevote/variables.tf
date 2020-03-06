variable "aks_kube_config"{
    description = "The configuration of the Kube"
}
variable "k8s_namespace"{
  description = "The namespace where the application will reside within the Kubernetes Cluster."
}
variable "docker_config_json" {
  description = "The Base64 encoded container registry credentials"
}
variable "fqdn"{
    description = "The fqdn assigned by the public ip address"
}

