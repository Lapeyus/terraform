# tests/integration/test_firewall_module.tftest.hcl

provider "google" {
  project = "kerewes-root-613169ca279cb281"
  region  = "us-central1"
}

variables {
  rules = [
    {
      project                 = "kerewes-root-613169ca279cb281"
      name                    = "integration-test-valid-rule"
      network                 = "default"
      priority                = 1000
      direction               = "INGRESS"
      source_ranges           = ["10.0.0.0/8"]
      allow                   = {
        protocol = "tcp"
        ports    = ["80", "443"]
      }
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    }
  ]
}

run "apply_valid_rule" {
  command = apply

  assert {
    condition = length(output.firewall_rules) == 1
    error_message = "The valid rule should be applied successfully"
  }
}

run "apply_invalid_rule" {
  command = apply

  variables {
    rules = [
      {
        project                 = "kerewes-root-613169ca279cb281"
        name                    = "integration-test-invalid-rule"
        network                 = "default"
        priority                = 1000
        direction               = "INGRESS"
        source_ranges           = ["0.0.0.0/0"]
        allow                   = {
          protocol = "tcp"
          ports    = ["80", "443"]
        }
        log_config = {
          metadata = "INCLUDE_ALL_METADATA"
        }
      }
    ]
  }

  expect_failures = [
    var.rules,
  ]

  assert {
    condition = length(output.firewall_rules) == 0
    error_message = "The invalid rule should not be applied"
  }
}
