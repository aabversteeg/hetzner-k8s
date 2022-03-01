resource "hcloud_ssh_key" "default" {
  name       = "default"
  public_key = file("/root/.ssh/id_rsa.pub")
}
