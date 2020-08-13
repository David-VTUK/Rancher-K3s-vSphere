variable vsphere_server {
  type        = string
  description = "FQDN or IP address of vCenter instance"
}

variable vsphere_user {
  type        = string
  description = "Username for the vCenter instance"
}

variable vsphere_password {
  type        = string
  description = "Password for the vCenter instance"
}

variable vsphere_datacenter {
  type        = string
  description = "Name of the vCenter Datacenter object"
}

variable vsphere_cluster {
  type        = string
  description = "Name of the vCenter Cluster object"
}

variable vsphere_network {
  type        = string
  description = "Name of the vDS/vSS Port Group to attach to the VM's"
}

variable vm_prefix {
  type        = string
  description = "Name prefix for VM's. A numerical value will be appended"
}

variable vm_count {
  type        = number
  description = "Number of K3s instances to create"
}

variable vm_datastore {
  type        = string
  description = "Name of the vCenter datastore object"
}

variable vm_cpucount {
  type        = number
  description = "Number of vCPU's to assign to the VM's"
}

variable vm_memory {
  type        = number
  description = "Amount of memory (in MB) to assign to the VM's"
}

variable vm_domainname {
  type        = string
  description = "Domain name suffix for the VM"
}

variable vm_network {
  type        = string
  description = "CIDR network to use with appended . IE - 172.16.10."
}

variable vm_netmask {
  type        = string
  description = "Subnet Mask length for VM's"
}

variable vm_gateway {
  type        = string
  description = "Gateway address for VM"
}

variable vm_dns {
  type        = string
  description = "IP address of DNS server"
}

variable lb_address {
  type        = string
  description = "IP address for the NGINX loadbalancer"
}

variable lb_prefix {
  type        = string
  description = "Name prefix for the Loadbalancer"
}

variable lb_datastore {
  type        = string
  description = "Datastore object to store the Loadbalancer VM"
}

variable lb_cpucount {
  type        = number
  description = "Number of CPU's to assign to the Loadbalancer VM"
}

variable lb_memory {
  type        = number
  description = "Amount of RAM in MB to assign to the Loadbalancer VM"
}

variable lb_domainname {
  type        = string
  description = "Domain name suffix for the VM"
}

variable lb_netmask {
  type        = string
  description = "Subnet mask for the Loadbalancer VM"
}

variable lb_gateway {
  type        = string
  description = "Gateway for the Loadbalancer VM"
}

variable lb_dns {
  type        = string
  description = "DNS Server for the Loadbalancer VM"
}

variable k3s_secret {
  type        = string
  description = "Secret for the K3s cluster"
}

variable certmanager_version {
  type        = string
  description = "Version of Certmanager to install"
}

variable rancher_hostname {
  type        = string
  description = "Name for the Rancher host"
}

variable rancher_version {
  type        = string
  description = "Version of Rancher to install"
}

variable host_username {
  type        = string
  description = "SSH username for the VM's"
}

variable host_password {
  type        = string
  description = "SSH password for the VM's"
}