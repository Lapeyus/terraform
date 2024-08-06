# tests/unit/input_validations.tftest.hcl

variables {
  rules = [
    {
      project                 = "example-project"
      name                    = "valid-rule"
      network                 = "dev"
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
    },
    {
      project                 = "example-project"
      name                    = "valid-rule-2"
      network                 = "prod"
      priority                = 1000
      direction               = "INGRESS"
      source_ranges           = ["192.168.1.0/24"]
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

run "valid_rule" {
  command = plan

  assert {
    condition = length(terraform.plan.resource_changes) == 2
    error_message = "Both valid rules should be included in the plan"
  }
}

run "invalid_rule" {
  command = plan

  variables {
    rules = [
      {
        project                 = "example-project"
        name                    = "invalid-rule"
        network                 = "prod"
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
    condition = length(terraform.plan.resource_changes) == 0
    error_message = "Invalid rule should not be included in the plan"
  }
}