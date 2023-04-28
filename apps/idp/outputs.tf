output "google_folder_attach_point" {
  description = "The created Google folders nested under another folder"
  value       = { for k, folder in module.project.folders : k => folder }
}

output "google_project_project" {
  description = "The created Google projects"
  value       = { for k, project in module.project.projects : k => project }
}

output "google_project_names" {
  description = "The created Google projects"
  value       = { for k, project in module.project.google_project_names : k => project }
}
