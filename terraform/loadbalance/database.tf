resource "digitalocean_database_cluster" "db-postgres-cluster" {
  name       = "db-postgres-cluster"
  engine     = "pg"
  version    = "13"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
}

resource "digitalocean_database_db" "redmine" {
  cluster_id = digitalocean_database_cluster.db-postgres-cluster.id
  name = "redmine"
}

resource "digitalocean_database_user" "redmine" {
  cluster_id = digitalocean_database_cluster.db-postgres-cluster.id
  name = "redmine"
}

resource "digitalocean_database_firewall" "redmine-fw" {
  cluster_id = digitalocean_database_cluster.db-postgres-cluster.id

  rule {
    type = "tag"
    value = "redmine-web"
  }
}

output "db_settings" {
  sensitive = true
  value = {
    "host": digitalocean_database_cluster.db-postgres-cluster.private_host
    "port": digitalocean_database_cluster.db-postgres-cluster.port
    "user": digitalocean_database_user.redmine.name
    "password": digitalocean_database_user.redmine.password
    "db_name": digitalocean_database_db.redmine.name
  }
}