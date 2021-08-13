resource "digitalocean_loadbalancer" "redmine-lb" {
  name = "redmine-lb"
  region = "fra1"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 80
    target_protocol = "http"
  }

  healthcheck {
    port = 80
    protocol = "http"
    path = "/"
  }

  droplet_ids = [digitalocean_droplet.redmine-1.id, digitalocean_droplet.redmine-2.id ]
}