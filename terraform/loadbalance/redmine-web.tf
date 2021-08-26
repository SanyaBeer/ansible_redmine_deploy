resource "digitalocean_droplet" "web" {
  image   = var.droplet_image
  count   = tonumber(var.droplet_count)
  name    = "${var.droplet_prefix}${count.index}"
  tags    = [var.app_tag, var.droplet_tag]
  region  = var.droplet_region
  size    = var.droplet_size

  private_networking = true

  ssh_keys = [
    digitalocean_ssh_key.default.id
  ]

  depends_on = [
    digitalocean_database_cluster.default,
    digitalocean_database_db.default,
    digitalocean_database_user.default
  ]

  connection {
    host = self.ipv4_address
    user = var.droplet_connection_user
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }

}

output "droplets_ips" {
  value = [
    for droplet in digitalocean_droplet.web:
    droplet.ipv4_address
  ]
}
