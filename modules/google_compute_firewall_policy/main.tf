resource "google_compute_firewall_policy" "default" {
  parent      = var.rules.parent
  short_name  = var.rules.short_name
  description = var.rules.description
}
resource "google_compute_firewall_policy_rule" "rules" {
  for_each = { for idx, rule in var.rules.rules : idx => rule }

  action                  = each.value.action
  direction               = each.value.direction
  firewall_policy         = google_compute_firewall_policy.default.name
  priority                = each.value.priority
  description             = each.value.description
  disabled                = each.value.disabled
  enable_logging          = each.value.enable_logging
  security_profile_group  = each.value.security_profile_group
  target_resources        = each.value.target_resources
  target_service_accounts = each.value.target_service_accounts
  tls_inspect             = each.value.tls_inspect
  match {
    dest_address_groups       = each.value.match.dest_address_groups
    dest_fqdns                = each.value.match.dest_fqdns
    dest_ip_ranges            = each.value.match.dest_ip_ranges
    dest_region_codes         = each.value.match.dest_region_codes
    dest_threat_intelligences = each.value.match.dest_threat_intelligences

    dynamic "layer4_configs" {
      for_each = each.value.match.layer4_configs
      content {
        ip_protocol = layer4_configs.value.ip_protocol
        ports       = layer4_configs.value.ports
      }
    }

    src_address_groups       = each.value.match.src_address_groups
    src_fqdns                = each.value.match.src_fqdns
    src_ip_ranges            = each.value.match.src_ip_ranges
    src_region_codes         = each.value.match.src_region_codes
    src_threat_intelligences = each.value.match.src_threat_intelligences
  }
}
