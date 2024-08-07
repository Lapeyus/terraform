# tests/apply_test.tftest.hcl

provider "google" {
  project = "kerewes-root-613169ca279cb281"
  region  = "us-central1"
}

variables {
  policy = {
    parent     = "organizations/562898704687"
    short_name = "apply-firewall"
    description = "Test firewall policy"
    rules = [
      {
        action          = "allow"
        direction       = "INGRESS"
        firewall_policy = "apply-policy"
        priority        = 1000
        match = {
          src_ip_ranges = ["0.0.0.0/0"]
          layer4_configs = [
            {
              ip_protocol = "tcp"
              ports       = ["80"]
            }
          ]
        }
      }
    ]
  }
}

run "apply_firewall_policy" {
  command = apply

  assert {
    condition     = google_compute_firewall_policy.default.short_name == "apply-firewall"
    error_message = "Firewall policy short_name did not match expected"
  }

  assert {
    condition     = length(google_compute_firewall_policy_rule.rules) == 1
    error_message = "Number of firewall rules did not match expected"
  }

  assert {
    condition     = google_compute_firewall_policy_rule.rules[0].action == "allow"
    error_message = "Firewall rule action did not match expected"
  }

  assert {
    condition     = google_compute_firewall_policy_rule.rules[0].direction == "INGRESS"
    error_message = "Firewall rule direction did not match expected"
  }

  assert {
    condition     = google_compute_firewall_policy_rule.rules[0].priority == 1000
    error_message = "Firewall rule priority did not match expected"
  }

  assert {
    condition     = google_compute_firewall_policy_rule.rules[0].match[0].layer4_configs[0].ip_protocol == "tcp"
    error_message = "Firewall rule IP protocol did not match expected"
  }

  assert {
    condition     = google_compute_firewall_policy_rule.rules[0].match[0].layer4_configs[0].ports[0] == "80"
    error_message = "Firewall rule ports did not match expected"
  }
}

run "override_apply_variable_value" {
  command = apply

  variables {
    policy = {
      parent      = "organizations/562898704687"
      short_name  = "override-apply-firewall"
      description = "Override test firewall policy"
      attachment_target = "organizations/562898704687"
      rules = [
        {
          action          = "deny"
          direction       = "EGRESS"
          firewall_policy = "override-apply-policy"
          priority        = 2000
          match = {
            src_ip_ranges = ["10.128.0.0/20"]
            dest_ip_ranges = ["0.0.0.0/0"]
            layer4_configs = [
              {
                ip_protocol = "udp"
                ports       = ["53"]
              }
            ]
          }
        }
      ]
    }
  }

  assert {
    condition     = google_compute_firewall_policy.default.short_name == "override-apply-firewall"
    error_message = "Overridden firewall policy short_name did not match expected"
  }

  assert {
    condition     = length(google_compute_firewall_policy_rule.rules) == 1
    error_message = "Number of firewall rules did not match expected"
  }

  assert {
    condition     = google_compute_firewall_policy_rule.rules[0].action == "deny"
    error_message = "Firewall rule action did not match expected"
  }

  assert {
    condition     = google_compute_firewall_policy_rule.rules[0].direction == "EGRESS"
    error_message = "Firewall rule direction did not match expected"
  }

  assert {
    condition     = google_compute_firewall_policy_rule.rules[0].priority == 2000
    error_message = "Firewall rule priority did not match expected"
  }

  assert {
    condition     = google_compute_firewall_policy_rule.rules[0].match[0].layer4_configs[0].ip_protocol == "udp"
    error_message = "Firewall rule IP protocol did not match expected"
  }

  assert {
    condition     = google_compute_firewall_policy_rule.rules[0].match[0].layer4_configs[0].ports[0] == "53"
    error_message = "Firewall rule ports did not match expected"
  }
}
