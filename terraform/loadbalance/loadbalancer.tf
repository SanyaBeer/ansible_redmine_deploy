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

  depends_on = [digitalocean_droplet.redmine-web]

  droplet_tag = "redmine-web"
}