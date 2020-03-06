variable "prefix" {
  description = "The prefix is written at the beginning of the name of each element"
}
variable "location" {
  default     = "eastus"
  description = "The Azure Region in which all resources should be provisioned"
}
variable "environment" {
  description = "The environment uses for azure resource tags"
}
variable "random" {
  description = "The random uses for name of each element after the environment"
}
variable "resource_group_name" {
  description = "resource_group_name"
}
variable "resource_group_location" {
  description = "resource_group_location"
}
variable "key_vault_id" {
  description = "key_vault_id"
}
variable "common_tags"{
    description = "Tag information"
}
variable "aks_kube_config"{
    description = "The configuration of the Kube"
}
variable "ingress_ip"{
    description = "The public IP address"
}
variable "k8s_namespace"{
  description = "The namespace where the application will reside within the Kubernetes Cluster."
}
