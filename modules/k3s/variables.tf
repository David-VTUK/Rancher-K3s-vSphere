variable first_node_ip {
  type        = string
  description = "IP of the first node in the VM set, this is used to init the K3s cluster"
}
variable subsequent_node_ips {
  type        = list(string)
  description = "List of the remaining node IP's to join to the K3s cluster"
}

variable k3s_secret {
  type        = string
  description = "Secret for the K3s cluster"
}

variable lb_address {
  type        = string
  description = "IP address for the NGINX loadbalancer"
}

variable host_username {
  type        = string
  description = "FQDN or IP address of vCenter Instance"
}

variable host_password {
  type        = string
  description = "FQDN or IP address of vCenter Instance"
}