locals {
  node_indexes   = range(var.num_nodes)
  kube_masters   = range(0, var.num_nodes, 3)
  control_panels = local.kube_masters
  kube_nodes     = setsubtract(local.node_indexes, local.kube_masters)
}

resource "hcloud_server" "nodes" {
  count        = var.num_nodes
  name         = "node${count.index + 1}"
  image        = var.vm_image
  server_type  = var.server_type
  ssh_keys     = [hcloud_ssh_key.default.id]
  firewall_ids = [hcloud_firewall.default.id]

  labels = {
    "load-balanced"      = true
    "etcd"               = true
    "kube-master"        = contains(local.kube_masters, count.index)
    "kube-control-plane" = contains(local.control_panels, count.index)
    "kube-node"          = contains(local.kube_nodes, count.index)
  }

  depends_on = [hcloud_network_subnet.default]

  network {
    network_id = hcloud_network.default.id
  }
}
