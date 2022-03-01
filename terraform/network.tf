resource "hcloud_network" "default" {
  name     = "default"
  ip_range = var.network_cidr
}
resource "hcloud_network_subnet" "default" {
  network_id   = hcloud_network.default.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = var.network_cidr
}
