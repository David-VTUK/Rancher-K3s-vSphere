resource "null_resource" "k3s_first_node" {
  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC='--write-kubeconfig-mode 644 --cluster-init --token ${var.k3s_secret} --tls-san ${var.lb_address}' sh -"
    ]

    connection {
      type     = "ssh"
      host     = var.first_node_ip
      user     = var.vm_ssh_user
      private_key = file("~/.ssh/id_rsa")
    }
  }
}

resource "null_resource" "k3s_subsequent_nodes" {

  count = length(var.subsequent_node_ips)
  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC='--write-kubeconfig-mode 644 --server https://${var.first_node_ip}:6443 --token ${var.k3s_secret}' sh -"
    ]

    connection {
      type     = "ssh"
      host     = element(var.subsequent_node_ips, count.index)
      user     = var.vm_ssh_user
      private_key = file("~/.ssh/id_rsa")
    }
  }
  depends_on = [null_resource.k3s_first_node]
}

resource "null_resource" "k3s_kubeconfig" {
  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.ssh/id_rsa ${var.vm_ssh_user}@${var.first_node_ip}:/etc/rancher/k3s/k3s.yaml ./kube_config_cluster.yml"
  }
  depends_on = [null_resource.k3s_subsequent_nodes]
}

resource "null_resource" "k3s_kubeconfig_rewrite" {
  provisioner "local-exec" {
    command = "sed -i 's/127.0.0.1/${var.first_node_ip}/g' ./kube_config_cluster.yml"
  }
  depends_on = [null_resource.k3s_kubeconfig]
}

