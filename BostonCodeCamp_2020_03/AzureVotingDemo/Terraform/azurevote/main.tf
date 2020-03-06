provider "kubernetes" {
  host                   = var.aks_kube_config.0.host
  username               = var.aks_kube_config.0.username
  password               = var.aks_kube_config.0.password
  client_certificate     = base64decode(var.aks_kube_config.0.client_certificate)
  client_key             = base64decode(var.aks_kube_config.0.client_key)
  cluster_ca_certificate = base64decode(var.aks_kube_config.0.cluster_ca_certificate)
}

locals{
    app_name="azure-vote-sample"
}

resource "kubernetes_secret" "docker-cfg" {
  metadata {
    name = "acr-creds"
    namespace = var.k8s_namespace
    labels = {
      app = local.app_name
    }
  }

  data = {
    ".dockerconfigjson" = base64decode(var.docker_config_json)
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_deployment" "vote-back" {
  
  metadata {
    name = "vote-back"
    namespace = var.k8s_namespace
    labels = {
      app = local.app_name
    }    
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "vote-back"
      }
    }

    template {
      metadata {
        labels = {
          app = "vote-back"
        }
      }

      spec {
        hostname  = "vote-back"
        container {
          name  = "vote-back"
          image = "redis"
         
          port {
            name = "http"
            container_port = "6379"
          }

      resources{
            limits{
              cpu = "0.5"
              memory = "512Mi"
            }
            requests{
              cpu = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "vote-back" {
 
  metadata {
    name = "vote-back-svc"
    namespace = var.k8s_namespace
    labels = {
      app = local.app_name
    }
  }

  spec {
    selector = {
      app = "${kubernetes_deployment.vote-back.metadata.0.name}"
    }

    port {
      port = "6379"
      target_port = "6379"
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_deployment" "vote-front" {
  
  metadata {
    name = "vote-front"
    namespace = var.k8s_namespace
    labels = {
      app = local.app_name
    }    
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "vote-front"
      }
    }

    template {
      metadata {
        labels = {
          app = "vote-front"
        }
      }

      spec {
        hostname  = "vote-front"
        container {
          name  = "vote-front"
          image = "dmdtfacr.azurecr.io/azure-vote-front:v2"
         
          port {
            name = "http"
            container_port = "8080"
          }

          env {
            name = "REDIS"
            value = kubernetes_service.vote-back.metadata.0.name
          }

          resources{
            limits{
              cpu = "0.5"
              memory = "512Mi"
            }
            requests{
              cpu = "250m"
              memory = "50Mi"
            }
          }
        }
        image_pull_secrets{
           name = kubernetes_secret.docker-cfg.metadata.0.name
        } 
      }
    }
  }
}

resource "kubernetes_service" "vote-front" {
 
  metadata {
    name = "vote-front-svc"
    namespace = var.k8s_namespace
    labels = {
      app = local.app_name
    }
  }

  spec {
    selector = {
      app = "${kubernetes_deployment.vote-front.metadata.0.name}"
    }

    port {
      port = "8080"
      target_port = "80"
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_ingress" "azurevote-ingress" {
  metadata {
    name = "azurevote-ingress"
    namespace = var.k8s_namespace
    annotations = {
      "kubernetes.io/ingress.class"                   = "nginx"
      "nginx.ingress.kubernetes.io/proxy-buffer-size" = "16k"
    }
  }

  spec {
    # tls {
    #   hosts       = ["${var.fqdn}"]
    #   secret_name =  "ingress"     
    # }

    rule {
      host = var.fqdn

      http {
        path {
          path = "/"

          backend {
            service_name = kubernetes_service.vote-front.metadata.0.name
            service_port = 8080
          }
        }
      }
    }
  }
}


# # "kubernetes.io/tls-acme"                        = "true"
# "nginx.ingress.kubernetes.io/ssl-redirect"      = "true"
#       "certmanager.k8s.io/cluster-issuer"             = "letsencrypt-prod"
     