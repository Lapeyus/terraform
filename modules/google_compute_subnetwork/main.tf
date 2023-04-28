resource "google_compute_subnetwork" "gke" {
  for_each = { for subnet in var.sub_networks : subnet.name => subnet }

  name                       = each.value.name
  region                     = each.value.gcp_region
  network                    = each.value.network
  ip_cidr_range              = each.value.subnetwork_cidr
  private_ip_google_access   = try(each.value.private_ip_google_access, false)
  private_ipv6_google_access = try(each.value.private_ipv6_google_access, "DISABLE_GOOGLE_ACCESS")
  project                    = "${var.project_name}-${each.value.env}-${var.random_id}"
  description                = try(each.value.description, null)
  purpose                    = try(each.value.purpose, null)
  role                       = try(each.value.role, null)
  stack_type                 = try(each.value.stack_type, null)
  ipv6_access_type           = try(each.value.ipv6_access_type, null)

  dynamic "secondary_ip_range" {
    for_each = try(each.value.secondary_ip_range, [])
    content {
      range_name    = secondary_ip_range.value.name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }

  dynamic "log_config" {
    for_each = try(each.value.log_config != null ? [each.value.log_config] : [], [])
    content {
      aggregation_interval = try(log_config.value.aggregation_interval, null)
      flow_sampling        = try(log_config.value.flow_sampling, null)
      metadata             = try(log_config.value.metadata, null)
      metadata_fields      = try(log_config.value.metadata_fields, null)
      filter_expr          = try(log_config.value.filter_expr, null)
    }
  }
}
