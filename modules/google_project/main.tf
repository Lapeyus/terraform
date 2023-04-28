# Folder nested under another folder.
resource "google_folder" "attach_point" {
  for_each     = { for env in var.environments : env.name => env }
  display_name = each.key
  parent       = var.attach_point
}

resource "google_project" "project" {
  for_each            = { for env in var.environments : env.name => env }
  name                = "${var.project_name}-${each.key}-${var.random_id}"
  project_id          = "${var.project_name}-${each.key}-${var.random_id}"
  folder_id           = google_folder.attach_point[each.key].id
  billing_account     = try(each.value.billing_account, null)
  skip_delete         = try(each.value.skip_delete, null)
  labels              = try(each.value.labels, null)
  auto_create_network = try(each.value.auto_create_network, null)
}

locals {
  expanded_environments = flatten([
    for env in var.environments : [
      for idx, service in env.services : merge(env, { service = service })
    ]
  ])
}

resource "google_project_service" "gcp_services" {
  for_each                   = { for env in local.expanded_environments : "${env.name}-${env.service}" => env }
  project                    = "${var.project_name}-${each.value.name}-${var.random_id}"
  service                    = each.value.service
  disable_dependent_services = each.value.disable_dependent_services != null ? each.value.disable_dependent_services : false
  disable_on_destroy         = each.value.disable_on_destroy != null ? each.value.disable_on_destroy : false
}
