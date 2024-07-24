output "folders" {
  value = merge(
    { for k, v in google_folder.layer1_folders : k => v.name },
    { for k, v in google_folder.layer2_folders : k => v.name },
    { for k, v in google_folder.layer3_folders : k => v.name },
    { for k, v in google_folder.layer4_folders : k => v.name },
    { for k, v in google_folder.layer5_folders : k => v.name },
    { for k, v in google_folder.layer6_folders : k => v.name },
    { for k, v in google_folder.layer7_folders : k => v.name },
    { for k, v in google_folder.layer8_folders : k => v.name },
    { for k, v in google_folder.layer9_folders : k => v.name },
    { for k, v in google_folder.layer10_folders : k => v.name }
  )
}

output "layer1_folders" {
  value = { for k, v in google_folder.layer1_folders : k => v.name }
}

output "layer2_folders" {
  value = { for k, v in google_folder.layer2_folders : k => v.name }
}

output "layer3_folders" {
  value = { for k, v in google_folder.layer3_folders : k => v.name }
}

output "layer4_folders" {
  value = { for k, v in google_folder.layer4_folders : k => v.name }
}

output "layer5_folders" {
  value = { for k, v in google_folder.layer5_folders : k => v.name }
}

output "layer6_folders" {
  value = { for k, v in google_folder.layer6_folders : k => v.name }
}

output "layer7_folders" {
  value = { for k, v in google_folder.layer7_folders : k => v.name }
}

output "layer8_folders" {
  value = { for k, v in google_folder.layer8_folders : k => v.name }
}

output "layer9_folders" {
  value = { for k, v in google_folder.layer9_folders : k => v.name }
}

output "layer10_folders" {
  value = { for k, v in google_folder.layer10_folders : k => v.name }
}

