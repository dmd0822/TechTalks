

# Initialize azure cli config
data "azurerm_client_config" "current" {}

# Read Azure client id from Vault
data "azurerm_key_vault_secret" "kubernetes-client-id" {
  name         = "kubernetes-client-id"
  key_vault_id = var.key_vault_id
}

# Read Azure client secret from Vault
data "azurerm_key_vault_secret" "kubernetes-client-secret" {
  name         = "kubernetes-client-secret"
  key_vault_id = var.key_vault_id
}

# Read Azure client secret from Vault
data "azurerm_key_vault_secret" "registry-dockerconfig" {
  name         = "registry-dockerconfig"
  key_vault_id = var.key_vault_id
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-${var.environment}-${var.random}-aks"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.prefix}-${var.environment}-aks-${var.random}-dns" #, but need to recreate existing envs
  
  linux_profile {
        admin_username = var.vm_user_name
        ssh_key {
            key_data = file(var.public_ssh_key_path)
        }
  }
    
  default_node_pool {
    name = "agentpool"
    node_count = var.aks_node_count
    vm_size = var.aks_node_vm_size
    os_disk_size_gb = var.aks_agent_os_disk_size
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "Standard"
  }

  service_principal {
    client_id     = data.azurerm_key_vault_secret.kubernetes-client-id.value
    client_secret = data.azurerm_key_vault_secret.kubernetes-client-secret.value
  }

  tags = merge(var.common_tags, { Name = "${var.prefix}-${var.environment}-aks" }) 
}

## Create Static Public IP Address to be used by Nginx Ingress
resource "azurerm_public_ip" "nginx_ingress" {
  name                         = "${var.prefix}-${var.environment}-nginx-ingress-pip"
  location                     = azurerm_kubernetes_cluster.aks.location
  resource_group_name          = azurerm_kubernetes_cluster.aks.node_resource_group
  allocation_method            = "Static"
  domain_name_label            = "${var.prefix}-${var.environment}-tf-demo"
  idle_timeout_in_minutes      = "30"
  sku                          = "Standard"
  
  tags = merge(var.common_tags, { Name = "${var.prefix}-${var.environment}-pip" }) 

  provisioner "local-exec" {
    command     = "Start-Sleep -Seconds 180"
    interpreter = ["PowerShell", "-Command"]
    when        = destroy
  }
}

