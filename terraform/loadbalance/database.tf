resource "digitalocean_database_cluster" "default" {
  name       = var.db_cluster_name
  engine     = var.db_cluster_engine
  version    = var.db_cluster_version
  size       = var.db_cluster_size
  region     = var.db_cluster_region
  node_count = tonumber(var.db_cluster_node_count)
}

resource "digitalocean_database_db" "default" {
  cluster_id = digitalocean_database_cluster.default.id
  name       = var.db_name
}

resource "digitalocean_database_user" "default" {
  cluster_id = digitalocean_database_cluster.default.id
  name       = var.db_user
}

resource "digitalocean_database_firewall" "default" {
  cluster_id = digitalocean_database_cluster.default.id

  rule {
    type     = "tag"
    value    = "redmine-web"
  }
}

output "db_settings" {
  sensitive = true
  value = {
    "host": digitalocean_database_cluster.default.private_host
    "port": digitalocean_database_cluster.default.port
    "user": digitalocean_database_user.default.name
    "password": digitalocean_database_user.default.password
    "db_name": digitalocean_database_db.default.name
  }
}