provider "azurerm" {
    version = "~>2.0"
    features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "terraformstatedmd"
    container_name       = "terraform-states"
    key                  = "tfstate"
  }
}

locals{
    common_tags = {
      source = "terraform"
      Environment = var.environment_tag
      BillingCode = var.billing_code_tag      
    }
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create the Resource Group
resource "azurerm_resource_group" "rg" {
    name = "${var.prefix}-${terraform.workspace}-${var.resource_group_name}"
    location = var.location
    
    tags = merge(local.common_tags, { Name = "${var.prefix}-${terraform.workspace}-rg" })
}

module "aks" {
  source                                 = "./aks"
  prefix                                 = var.prefix
  random                                 = random_integer.ri.result
  location                               = var.location
  resource_group_name                    = azurerm_resource_group.rg.name
  resource_group_location                = azurerm_resource_group.rg.location
  environment                            = terraform.workspace
  key_vault_id                           = var.key_vault_id
  common_tags                            = local.common_tags
}

module "ingress" {
  source                                 = "./ingress"
  prefix                                 = var.prefix
  random                                 = random_integer.ri.result
  location                               = var.location
  resource_group_name                    = azurerm_resource_group.rg.name
  resource_group_location                = azurerm_resource_group.rg.location
  environment                            = terraform.workspace
  key_vault_id                           = var.key_vault_id
  common_tags                            = local.common_tags
  aks_kube_config                        = module.aks.kube_config
  ingress_ip                             = module.aks.ingress_ip
  k8s_namespace                          = var.k8s_namespace
}

module "azurevote"{
  source                                 = "./azurevote"
  aks_kube_config                        = module.aks.kube_config
  docker_config_json                     = module.aks.docker_config_json
  fqdn                             = module.aks.fqdn
  k8s_namespace                          = module.ingress.k8s_ns_name
}