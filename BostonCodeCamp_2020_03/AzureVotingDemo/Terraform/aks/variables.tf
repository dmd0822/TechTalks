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

}
variable "aks_node_count" {
    description = "The number of nodes for the cluster."
    default = 2
}
variable "aks_node_vm_size" {
    description = "The size of the Virtual Machine."
    default = "Standard_D4s_v3"
}
variable "aks_agent_os_disk_size" {
    description = "Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 applies the default disk size for that agentVMSize."
    default = 40
}

variable "vm_user_name" {
    description = "User name for the VM"
    default = "vmuser1"
}
variable "public_ssh_key_path" {
    description = "Public key path for SSH."
    default = "~/.ssh/id_rsa.pub"
}

