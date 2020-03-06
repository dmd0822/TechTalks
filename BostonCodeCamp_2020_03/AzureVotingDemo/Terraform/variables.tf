variable "resource_group_name" {
    description = "Name of the resource group."
}
variable "location" {
    default     = "eastus"
    description = "Location of the cluster."
}
variable "billing_code_tag" {
    default     = "ABC123"
}
variable "environment_tag" { 
    default     = "dev"
}
variable "prefix" {
  default     = "dmd"
  description = "The prefix is written at the beginning of the name of each element"
}
variable "key_vault_id" {
  description = "The Azure Key Vault identifier which stores infrastructure secrets"
}
variable "k8s_namespace"{
  default = "tempns"
  description = "The namespace where the application will reside within the Kubernetes Cluster."
}
