resource "digitalocean_droplet" "redmine-web" {
  image = "ubuntu-20-04-x64"
  count = 2
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

  provisioner "local-exec" {
    command = "ansible-playbook -i '${self.ipv4_address}' --private-key ${var.pvt_key} -e 'db_user=${digitalocean_database_user.redmine.name} db_password=${digitalocean_database_user.redmine.password} db_port=${digitalocean_database_cluster.db-postgres-cluster.port} db_host=${digitalocean_database_cluster.db-postgres-cluster.private_host} db_database_name=${digitalocean_database_db.redmine.name}' cluster.yml"
    working_dir = "./../../"
  }
}

output "droplet_ip_addresses" {
  value = {
    for droplet in digitalocean_droplet.redmine-web:
    droplet.name => droplet.ipv4_address
  }
}