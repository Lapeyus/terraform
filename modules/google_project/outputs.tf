# Folders
output "folders" {
  value = google_folder.attach_point.*
}

# Projects
output "projects" {
  value = google_project.project.*
}

output "google_project_names" {
  description = "The created Google projects"
  value       = { for k, project in google_project.project : k => project.name }
}
