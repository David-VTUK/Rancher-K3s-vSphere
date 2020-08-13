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

variable host {
  type        = string
  description = "IP address of the node used to install Cert-Manager and Rancher"
}