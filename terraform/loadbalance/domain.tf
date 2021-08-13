resource "digitalocean_domain" "default" {
  name = "sanyabeer.xyz"
  ip_address = digitalocean_loadbalancer.redmine-lb.ip
}

resource "digitalocean_record" "CNAME-www" {
  domain = digitalocean_domain.default.name
  type = "CNAME"
  name = "www"
  value = "@"
}
