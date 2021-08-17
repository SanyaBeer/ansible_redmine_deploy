resource "digitalocean_droplet" "redmine-web" {
  image = "ubuntu-20-04-x64"
  count = 1
  name = "redmine-web-${count.index}"
  tags = ["redmine-web"]
  region = "fra1"
  size = "s-1vcpu-1gb"
  private_networking = true
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  depends_on = [
    digitalocean_database_cluster.db-postgres-cluster,
    digitalocean_database_db.redmine,
    digitalocean_database_user.redmine
  ]

  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }

}

output "droplets_ips" {
  value = [
    for droplet in digitalocean_droplet.redmine-web:
    droplet.ipv4_address
  ]
}
