provider "google" {
  project = "kerewes-root-613169ca279cb281"
  region  = "us-central1"
}

run "create_folders" {
  command = apply

  variables {
    folders = {
      "layer1_folder_1" = {
        name               = "L1-${substr(replace(timestamp(), "-", ""), 0, 8)}"
        external_parent_id = "organizations/562898704687"
      }
      "layer2_folder_1" = {
        name             = "L2-${substr(replace(timestamp(), "-", ""), 0, 8)}"
        parent_entry_key = "layer1_folder_1"
      }
      "layer3_folder_1" = {
        name             = "L3-${substr(replace(timestamp(), "-", ""), 0, 8)}"
        parent_entry_key = "layer2_folder_1"
      }
      "layer4_folder_1" = {
        name             = "L4-${substr(replace(timestamp(), "-", ""), 0, 8)}"
        parent_entry_key = "layer3_folder_1"
      }
      "layer5_folder_1" = {
        name             = "L5-${substr(replace(timestamp(), "-", ""), 0, 8)}"
        parent_entry_key = "layer4_folder_1"
      }
      "layer6_folder_1" = {
        name             = "L6-${substr(replace(timestamp(), "-", ""), 0, 8)}"
        parent_entry_key = "layer5_folder_1"
      }
      "layer7_folder_1" = {
        name             = "L7-${substr(replace(timestamp(), "-", ""), 0, 8)}"
        parent_entry_key = "layer6_folder_1"
      }
      "layer8_folder_1" = {
        name             = "L8-${substr(replace(timestamp(), "-", ""), 0, 8)}"
        parent_entry_key = "layer7_folder_1"
      }
      "layer9_folder_1" = {
        name             = "L9-${substr(replace(timestamp(), "-", ""), 0, 8)}"
        parent_entry_key = "layer8_folder_1"
      }
      "layer10_folder_1" = {
        name             = "L10-${substr(replace(timestamp(), "-", ""), 0, 8)}"
        parent_entry_key = "layer9_folder_1"
      }
    }
  }

  assert {
    condition     = length([for k, v in var.folders : k if v.parent_entry_key == "layer1_folder_1"]) == 1
    error_message = "Layer 1 folders count does not match expected"
  }

  assert {
    condition     = length([for k, v in var.folders : k if v.parent_entry_key == "layer2_folder_1"]) == 1
    error_message = "Layer 2 folders count does not match expected"
  }

  assert {
    condition     = length([for k, v in var.folders : k if v.parent_entry_key == "layer3_folder_1"]) == 1
    error_message = "Layer 3 folders count does not match expected"
  }

  assert {
    condition     = length([for k, v in var.folders : k if v.parent_entry_key == "layer4_folder_1"]) == 1
    error_message = "Layer 4 folders count does not match expected"
  }

  assert {
    condition     = length([for k, v in var.folders : k if v.parent_entry_key == "layer5_folder_1"]) == 1
    error_message = "Layer 5 folders count does not match expected"
  }

  assert {
    condition     = length([for k, v in var.folders : k if v.parent_entry_key == "layer6_folder_1"]) == 1
    error_message = "Layer 6 folders count does not match expected"
  }

  assert {
    condition     = length([for k, v in var.folders : k if v.parent_entry_key == "layer7_folder_1"]) == 1
    error_message = "Layer 7 folders count does not match expected"
  }

  assert {
    condition     = length([for k, v in var.folders : k if v.parent_entry_key == "layer8_folder_1"]) == 1
    error_message = "Layer 8 folders count does not match expected"
  }

  assert {
    condition     = length([for k, v in var.folders : k if v.parent_entry_key == "layer9_folder_1"]) == 1
    error_message = "Layer 9 folders count does not match expected"
  }

  assert {
    condition     = length([for k, v in var.folders : k if v.parent_entry_key == "layer10_folder_1"]) == 0
    error_message = "Layer 10 folders count does not match expected"
  }
}
