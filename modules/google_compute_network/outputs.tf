output "google_project_vpc" {
  description = "The created Google projects"
  value       = { for k, network in google_compute_network.network : k => network.id }
}