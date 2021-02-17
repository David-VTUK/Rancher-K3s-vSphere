terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    null = {
      source = "hashicorp/null"
    }
    rancher2 = {
      source = "rancher/rancher2"
    }
  }
  required_version = ">= 0.13"
}

