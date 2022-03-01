locals {
  source_ips = concat(var.whitelisted_cidrs, [var.network_cidr])
}

resource "hcloud_firewall" "default" {
  name = "default"

  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = local.source_ips
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "any"
    source_ips = local.source_ips
  }

  rule {
    direction  = "in"
    protocol   = "udp"
    port       = "any"
    source_ips = local.source_ips
  }
}
