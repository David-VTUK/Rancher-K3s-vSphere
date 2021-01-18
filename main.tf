module "nodes" {
  source             = "./modules/nodes"
  vsphere_server     = var.vsphere_server
  vsphere_user       = var.vsphere_user
  vsphere_password   = var.vsphere_password
  vsphere_datacenter = var.vsphere_datacenter
  vsphere_cluster    = var.vsphere_cluster
  vsphere_network    = var.vsphere_network

  vm_prefix     = var.vm_prefix
  vm_count      = var.vm_count
  vm_datastore  = var.vm_datastore
  vm_cpucount   = var.vm_cpucount
  vm_memory     = var.vm_memory
  vm_domainname = var.vm_domainname
  vm_startip    = var.vm_startip
  vm_network    = var.vm_network
  vm_netmask    = var.vm_netmask
  vm_gateway    = var.vm_gateway
  vm_dns        = var.vm_dns
  vm_template   = var.vm_template

  lb_address    = var.lb_address
  lb_prefix     = var.lb_prefix
  lb_datastore  = var.lb_datastore
  lb_cpucount   = var.lb_cpucount
  lb_memory     = var.lb_memory
  lb_domainname = var.lb_domainname
  lb_netmask    = var.lb_netmask
  lb_gateway    = var.lb_gateway
  lb_dns        = var.lb_dns

  vm_ssh_key = var.vm_ssh_key
  vm_ssh_user = var.vm_ssh_user
}


module "k3s" {
  source              = "./modules/k3s"
  first_node_ip       = element(module.nodes.instance_ip_addr, 0)
  subsequent_node_ips = slice(module.nodes.instance_ip_addr, 1, length(module.nodes.instance_ip_addr))
  k3s_secret          = var.k3s_secret
  lb_address          = module.nodes.lb_addr
  vm_ssh_key = var.vm_ssh_key
  vm_ssh_user = var.vm_ssh_user

  depends_on = [module.nodes]
}

module "rancher" {
  source              = "./modules/rancher"

  certmanager_version = var.certmanager_version
  rancher_hostname    = var.rancher_hostname
  rancher_version     = var.rancher_version


  depends_on = [module.k3s]
}

resource "null_resource" "wait_for_rancher" {
  provisioner "local-exec" {
    command = <<EOF
      while true; do curl -kv https://"${var.rancher_hostname}" 2>&1 | grep -q "dynamiclistener-ca"; if [ $? != 0 ]; then echo "Rancher URL isn't ready yet"; sleep 5; continue; fi; break; done; echo "Rancher URL is Ready";
              EOF
  }

  depends_on = [module.rancher]
}

provider "helm" {
  kubernetes {
    config_path = "./kube_config_cluster.yml"
  }
}

provider "kubernetes" {
  config_path = "./kube_config_cluster.yml"
}

provider "rancher2" {
  alias = "rancher-b"
  api_url   = "https://${var.rancher_hostname}"
  bootstrap = true
  insecure = true
}
# Bootstrap rancher setup
resource "rancher2_bootstrap" "rancher-admin" {
  provider = rancher2.rancher-b
  password = var.rancher_password
  telemetry = true
  depends_on = [null_resource.wait_for_rancher]
}
# Create actual admin rancher setup
provider "rancher2" {
  alias = "rancher-a"
  api_url = "https://${var.rancher_hostname}"
  token_key = rancher2_bootstrap.rancher-admin.token
  insecure = true
}