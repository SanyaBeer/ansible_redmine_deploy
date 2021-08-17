terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
  required_version = "~> 1.0"
  backend "remote" {
    organization = "aj_pivovarov"

    workspaces {
      name = "do_redmine"
    }
  }
}

variable "do_token" {}
variable "pvt_key" {}
variable "pub_key" {}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = "office-pc"
}
