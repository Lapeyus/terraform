resource "random_string" "random_id" {
  length  = 4
  special = false
  lower   = true
  upper   = false

  lifecycle {
    ignore_changes = [length, special, lower, upper]
  }
}

module "folders" {
  source  = "../../modules/google_folder/"
  folders = var.folders
}

resource "google_folder" "attach_point" {
  display_name = var.project_name
  parent       = var.attach_point
}

module "project" {
  source       = "../../modules/google_project/"
  attach_point = google_folder.attach_point.name
  project_name = var.project_name
  environments = var.environments
  random_id    = random_string.random_id.result
  depends_on = [
    google_folder.attach_point
  ]
}

module "network" {
  source       = "../../modules/google_compute_network/"
  project_name = var.project_name
  networks     = var.networks
  random_id    = random_string.random_id.result
  depends_on = [
    module.project,
  ]
}

module "sub_network" {
  source       = "../../modules/google_compute_subnetwork/"
  project_name = var.project_name
  sub_networks = var.sub_networks
  random_id    = random_string.random_id.result
  depends_on = [
    module.project,
    module.network
  ]
}

module "firewall" {
  source       = "../../modules/google_compute_firewall/"
  project_name = var.project_name
  firewalls    = var.firewalls
  random_id    = random_string.random_id.result
  depends_on = [
    module.project,
    module.network
  ]
}

module "google_cloud_asset_folder_feed" {
  source             = "../../modules/google_cloud_asset_folder_feed/"
  folder_feed_config = var.folder_feed_config
  project_name = var.project_name
}