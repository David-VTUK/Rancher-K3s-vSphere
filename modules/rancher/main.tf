resource "helm_release" "rancher" {
  name       = "rancher"
  repository = "https://releases.rancher.com/server-charts/latest" 
  chart      = "rancher"
  version    = var.rancher_version
  namespace  = "cattle-system"

  set {
    name  = "hostname"
    value = var.rancher_hostname
  }

  depends_on = [helm_release.cert-manager]
}

resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io" 
  chart      = "cert-manager"
  version    = var.certmanager_version
  namespace  = "cert-manager"

  depends_on = [null_resource.cert-manager-prereqs]
}


resource "null_resource" "cert-manager-prereqs" {

  provisioner "local-exec" {
    command = "kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.15.0/cert-manager.crds.yaml --kubeconfig=kube_config_cluster.yml"
  }

    provisioner "local-exec" {
    command = "kubectl create ns cattle-system --kubeconfig=kube_config_cluster.yml"
  }

    provisioner "local-exec" {
    command = "kubectl create ns cert-manager --kubeconfig=kube_config_cluster.yml"
  }
}

