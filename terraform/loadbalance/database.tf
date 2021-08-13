resource "digitalocean_database_cluster" "db-postgres-cluster" {
  name       = "db-postgres-cluster"
  engine     = "pg"
  version    = "13"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
}