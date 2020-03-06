provider "helm" {
  kubernetes {
    host                   = var.aks_kube_config.0.host
    username               = var.aks_kube_config.0.username
    password               = var.aks_kube_config.0.password
    
    client_certificate     = base64decode(var.aks_kube_config.0.client_certificate)
    client_key             = base64decode(var.aks_kube_config.0.client_key)
    cluster_ca_certificate = base64decode(var.aks_kube_config.0.cluster_ca_certificate)
  }
}

# Initialize Kubernetess provider
provider "kubernetes" {
  host                   = var.aks_kube_config.0.host
  username               = var.aks_kube_config.0.username
  password               = var.aks_kube_config.0.password
  client_certificate     = base64decode(var.aks_kube_config.0.client_certificate)
  client_key             = base64decode(var.aks_kube_config.0.client_key)
  cluster_ca_certificate = base64decode(var.aks_kube_config.0.cluster_ca_certificate)
}

resource "kubernetes_namespace" "certmanager" {
  metadata {
    name = "cert-manager"
  }
}

resource "kubernetes_namespace" "app_ns" {
  metadata {
    name = var.k8s_namespace
  }
}

data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = data.helm_repository.stable.metadata.0.name
  chart      = "nginx-ingress"
  namespace  = var.k8s_namespace

  set {
    name = "controller.replicaCount"
    value = "1"
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = var.ingress_ip
  }
}

data "template_file" "kube-lego" {
  template = <<EOF
  
config:
  LEGO_EMAIL: dave@davemdavis.net
  LEGO_URL: https://acme-v01.api.letsencrypt.org/directory

rbac:
  create: true
  serviceAccountName: default

EOF
}

resource "helm_release" "kube-lego" {
  count      = "1"
  name       = "kube-lego"
  repository = data.helm_repository.stable.metadata.0.name
  chart      = "kube-lego"
  namespace  = "cert-manager"

  values = [
    "${data.template_file.kube-lego.rendered}"
  ]

  depends_on = [helm_release.nginx_ingress]
}