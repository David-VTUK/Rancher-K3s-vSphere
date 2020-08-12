output "instance_ip_addr" {
  value = vsphere_virtual_machine.k3s-nodes.*.default_ip_address
}

output "first_node_ip_addr" {
  value = vsphere_virtual_machine.k3s-nodes.0.default_ip_address
}

output "lb_addr" {
  value = vsphere_virtual_machine.k3s-lb.default_ip_address
}