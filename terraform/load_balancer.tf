resource "hcloud_load_balancer" "external" {
  count              = min(1, var.num_nodes)
  name               = "lb${count.index + 1}"
  load_balancer_type = "lb11"
  location           = "nbg1"
}

resource "hcloud_managed_certificate" "default" {
  name         = "default"
  domain_names = [var.external_fqdn, "*.${var.external_fqdn}"]
}

resource "hcloud_load_balancer_service" "https" {
  count            = length(hcloud_load_balancer.external)
  load_balancer_id = hcloud_load_balancer.external[count.index].id
  protocol         = "https"
  destination_port = 31443
  http {
    redirect_http = "true"
    certificates  = [hcloud_managed_certificate.default.id]
  }
}

resource "hcloud_load_balancer_network" "lb_network" {
  count            = length(hcloud_load_balancer.external)
  load_balancer_id = hcloud_load_balancer.external[count.index].id
  network_id       = hcloud_network.default.id
}

resource "hcloud_load_balancer_target" "web_targets" {
  count            = length(hcloud_load_balancer.external)
  load_balancer_id = hcloud_load_balancer.external[count.index].id
  type             = "label_selector"
  label_selector   = "load-balanced=true"
  use_private_ip   = true
  depends_on       = [hcloud_load_balancer_network.lb_network]
}
