#cloud-config
users:
  - name: ${vm_ssh_user}
    ssh-authorized-keys:
      - ${vm_ssh_key}
    sudo: ALL=(ALL) NOPASSWD:ALL