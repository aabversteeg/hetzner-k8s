variable "hcloud_token" {
  type = string
}

variable "network_cidr" {
  type    = string
  default = "10.0.0.0/8"
}

variable "whitelisted_cidrs" {
  type = list(string)
}

variable "external_fqdn" {
  type = string
}

variable "num_nodes" {
  type = number
}

variable "vm_image" {
  type    = string
  default = "ubuntu-20.04"

}

variable "server_type" {
  type    = string
  default = "cx21"
}
