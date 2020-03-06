# All the Cool Kids Use Terraform to Deploy Kubernetes ...So Can You! #

This code is from a talk I gave at Boston Code Camp Mar 2020. It uses a demo app that Microsoft put together [Quickstart: Deploy an Azure Kubernetes Service cluster using the Azure CLI](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough). I took it a step forward and deployed it using Terraform.


## Requirements ##

* Azure Account
* Container Registry (ACR)
* Azure CLI - Installed Locally
* Terraform CLI - Installed Locally
* Kubernetes CLI (Kubectl) - Installed Locally
* Helm -Installed Locally

## Commands ##

terraform init 
terraform plan -out out.plan
terraform apply "out.plan"
terraform destroy
