# test/input_validations.tftest.hcl

run "valid_folders" {
  command = plan

  variables {
    folders = {
      layer1 = {
        name               = "Layer 1"
        external_parent_id = "organizations/123456789"
      }
      layer2 = {
        name               = "Layer 2"
        parent_entry_key   = "layer1"
      }
    }
  }

  assert {
    condition     = length(var.folders) == 2
    error_message = "Folders validation failed"
  }
}

run "invalid_folders" {
  command = plan

  variables {
    folders = {
      invalid1 = {
        name               = "Invalid 1"
        external_parent_id = null
        parent_entry_key   = null
      }
      invalid2 = {
        name               = "Invalid 2"
        external_parent_id = "organizations/123456789"
        parent_entry_key   = "layer1"
      }
      invalid3 = {
        name               = "Invalid 3!"
        external_parent_id = "organizations/123456789"
      }
      invalid4 = {
        name               = "Invalid 4"
        external_parent_id = "org/123456789"
      }
    }
  }

  assert {
    condition = false
    error_message = "Expected failures did not occur for invalid folders"
  }

  expect_failures = [
    "folders.invalid1",
    "folders.invalid2",
    "folders.invalid3",
    "folders.invalid4",
  ]
}
