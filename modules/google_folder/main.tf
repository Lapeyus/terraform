resource "google_folder" "root_folders" {
  for_each     = { for key, folder in var.folders : key => folder if folder.parent_key == null }
  display_name = each.value.display_name
  parent       = each.value.parent
}

resource "google_folder" "sub_folders" {
  for_each     = { for key, folder in var.folders : key => folder if folder.parent_key != null }
  display_name = each.value.display_name
  parent       = google_folder.root_folders[each.value.parent_key].name
}

