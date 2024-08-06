resource "google_compute_firewall" "firewall" {
  for_each                = { for idx, fw in var.firewalls : idx => fw }
  project                 = each.value.project
  name                    = each.value.name
  network                 = each.value.network
  priority                = each.value.priority
  description             = try(each.value.description, null)
  destination_ranges      = try(each.value.destination_ranges, null)
  direction               = each.value.direction
  disabled                = try(each.value.disabled, null)
  source_ranges           = try(each.value.source_ranges, null)
  source_service_accounts = try(each.value.source_service_accounts, null)
  source_tags             = try(each.value.source_tags, null)
  target_service_accounts = try(each.value.target_service_accounts, null)
  target_tags             = try(each.value.target_tags, null)

  dynamic "allow" {
    for_each = try(lookup(each.value, "allow", null) != null ? [each.value.allow] : [], [])
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  dynamic "deny" {
    for_each = try(lookup(each.value, "deny", null) != null ? [each.value.deny] : [], [])
    content {
      protocol = deny.value.protocol
      ports    = deny.value.ports
    }
  }

  dynamic "log_config" {
    for_each = try(each.value.metadata != null ? [1] : [], [])
    content {
      metadata = each.value.metadata
    }
  }
}
