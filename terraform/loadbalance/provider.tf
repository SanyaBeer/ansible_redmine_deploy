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

// DO settings
variable "do_token" {}

// ssh keys
variable "ssh_key_name" {}
variable "pvt_key" {}
variable "pub_key" {}

// Global application settings
variable "app_tag" {}
variable "app_region" {}

// Droplets settings
variable "droplet_image" {}
variable "droplet_prefix" {}
variable "droplet_count" {}
variable "droplet_tag" {}
variable "droplet_region" {}
variable "droplet_size" {}

variable "droplet_connection_user" {}

variable "db_cluster_name" {}
variable "db_cluster_engine" {}
variable "db_cluster_version" {}
variable "db_cluster_size" {}
variable "db_cluster_region" {}
variable "db_cluster_node_count" {}

variable "db_name" {}
variable "db_user" {}




provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "default" {
  name = var.ssh_key_name
  public_key = file(var.pub_key)
}

//data "digitalocean_ssh_key" "redmine" {
//  name = var.ssh_key_name
//  public_key = file(var.pub_key)
//}
