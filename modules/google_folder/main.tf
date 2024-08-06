resource "google_folder" "layer1_folders" {
  for_each     = { for key, folder in var.folders : key => folder if folder.external_parent_id != null }
  display_name = each.value.name != null ? each.value.name : each.key
  parent       = each.value.external_parent_id
}


locals {
  layer1_keys = keys(google_folder.layer1_folders)
}

resource "google_folder" "layer2_folders" {
  for_each      = { for key, folder in var.folders : key => folder if try(contains(local.layer1_keys, folder.parent_entry_key), false) }
  display_name = each.value.name != null ? each.value.name : each.key
  parent       = google_folder.layer1_folders[each.value.parent_entry_key].name
  depends_on   = [google_folder.layer1_folders]
}

locals {
  layer2_keys = keys(google_folder.layer2_folders)
}

resource "google_folder" "layer3_folders" {
  for_each     = { for key, folder in var.folders : key => folder if try(contains(local.layer2_keys, folder.parent_entry_key), false) }
  display_name = each.value.name != null ? each.value.name : each.key
  parent       = google_folder.layer2_folders[each.value.parent_entry_key].name
  depends_on   = [google_folder.layer2_folders]
}

locals {
  layer3_keys = keys(google_folder.layer3_folders)
}


resource "google_folder" "layer4_folders" {
  for_each     = { for key, folder in var.folders : key => folder if try(contains(local.layer3_keys, folder.parent_entry_key), false) }
  display_name = each.value.name != null ? each.value.name : each.key
  parent       = google_folder.layer3_folders[each.value.parent_entry_key].name
  depends_on   = [google_folder.layer3_folders]
}

locals {
  layer4_keys = keys(google_folder.layer4_folders)
}

resource "google_folder" "layer5_folders" {
  for_each     = { for key, folder in var.folders : key => folder if try(contains(local.layer4_keys, folder.parent_entry_key), false) }
  display_name = each.value.name != null ? each.value.name : each.key
  parent       = google_folder.layer4_folders[each.value.parent_entry_key].name
  depends_on   = [google_folder.layer4_folders]
}

locals {
  layer5_keys = keys(google_folder.layer5_folders)
}

resource "google_folder" "layer6_folders" {
  for_each     = { for key, folder in var.folders : key => folder if try(contains(local.layer5_keys, folder.parent_entry_key), false) }
  display_name = each.value.name != null ? each.value.name : each.key
  parent       = google_folder.layer5_folders[each.value.parent_entry_key].name
  depends_on   = [google_folder.layer5_folders]
}

locals {
  layer6_keys = keys(google_folder.layer6_folders)
}

resource "google_folder" "layer7_folders" {
  for_each     = { for key, folder in var.folders : key => folder if try(contains(local.layer6_keys, folder.parent_entry_key), false) }
  display_name = each.value.name != null ? each.value.name : each.key
  parent       = google_folder.layer6_folders[each.value.parent_entry_key].name
  depends_on   = [google_folder.layer6_folders]
}

locals {
  layer7_keys = keys(google_folder.layer7_folders)
}

resource "google_folder" "layer8_folders" {
  for_each     = { for key, folder in var.folders : key => folder if try(contains(local.layer7_keys, folder.parent_entry_key), false) }
  display_name = each.value.name != null ? each.value.name : each.key
  parent       = google_folder.layer7_folders[each.value.parent_entry_key].name
  depends_on   = [google_folder.layer7_folders]
}

locals {
  layer8_keys = keys(google_folder.layer8_folders)
}

resource "google_folder" "layer9_folders" {
  for_each     = { for key, folder in var.folders : key => folder if try(contains(local.layer8_keys, folder.parent_entry_key), false) }
  display_name = each.value.name != null ? each.value.name : each.key
  parent       = google_folder.layer8_folders[each.value.parent_entry_key].name
  depends_on   = [google_folder.layer8_folders]
}

locals {
  layer9_keys = keys(google_folder.layer9_folders)
}

resource "google_folder" "layer10_folders" {
  for_each     = { for key, folder in var.folders : key => folder if try(contains(local.layer9_keys, folder.parent_entry_key), false) }
  display_name = each.value.name != null ? each.value.name : each.key
  parent       = google_folder.layer9_folders[each.value.parent_entry_key].name
  depends_on   = [google_folder.layer9_folders]
}
