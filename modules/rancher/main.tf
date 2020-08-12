resource "null_resource" "install_rancher" {

  provisioner "file" {
    content = templatefile("${path.module}/templates/install.sh.tpl", {
      certmanager_version = var.certmanager_version
      rancher_hostname    = var.rancher_hostname
      rancher_version     = var.rancher_version
    })
    destination = "/tmp/installrancher.sh"

    connection {
      type     = "ssh"
      host     = var.host
      user     = var.host_username
      password = var.host_password
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sh /tmp/installrancher.sh"
    ]

    connection {
      type     = "ssh"
      host     = var.host
      user     = var.host_username
      password = var.host_password
    }
  }
}