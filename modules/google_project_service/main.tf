# Enable GCP services for the project
resource "google_project_service" "gcp_services" {
  project                    = var.gcp_project
  count                      = length(var.enabled_services)
  service                    = var.enabled_services[count.index]
  disable_dependent_services = false
  disable_on_destroy         = false
}