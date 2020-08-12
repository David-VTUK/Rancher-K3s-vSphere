resource "null_resource" "k3s_first_node" {
  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC='--write-kubeconfig-mode 644 --cluster-init --token ${var.k3s_secret} --tls-san ${var.lb_address}' sh -"
    ]

    connection {
      type     = "ssh"
      host     = var.first_node_ip
      user     = "packerbuilt"
      password = "PackerBuilt!"
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
      host     = element("${var.subsequent_node_ips}", count.index)
      user     = "packerbuilt"
      password = "PackerBuilt!"
    }
  }
  depends_on = [null_resource.k3s_first_node]
}

