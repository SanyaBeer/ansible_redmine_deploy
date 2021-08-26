// DO settings
do_token = ""

// ssh keys
ssh_key_name = "terraform"
pvt_key = "~/.ssh/id_rsa"
pub_key = "~/.ssh/id_rsa.pub"

// Global application settings
app_tag = "terraform"
app_region = "fra1"

// Droplets settings
droplet_image = "ubuntu-20-04-x64"
droplet_prefix = "droplet-"
droplet_count = 1
droplet_tag = "droplet"
droplet_region = "fra1"
droplet_size = "s-1vcpu-1gb"

droplet_connection_user = "root"

db_cluster_name = "db-postgres-cluster"
db_cluster_engine = "pg"
db_cluster_version = "13"
db_cluster_size = "db-s-1vcpu-1gb"
db_cluster_region = "fra1"
db_cluster_node_count = 1

db_name = "terraform"
db_user = "terraform"