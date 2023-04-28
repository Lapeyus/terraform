output "created_folders" {
  value = merge(
    { for folder in google_folder.root_folders : folder.display_name => folder.id },
    { for folder in google_folder.sub_folders : folder.display_name => folder.id }
  )
  description = "A map of the created folder names and their respective IDs."
}
