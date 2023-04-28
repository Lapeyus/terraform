resource "google_compute_network" "network" {
  for_each                                  = { for name in var.networks : name.name => name }
  project                                   = "${var.project_name}-${each.value.env}-${var.random_id}"
  name                                      = each.value.name
  description                               = try(each.value.description, "")
  auto_create_subnetworks                   = try(each.value.auto_create_subnetworks, false)
  routing_mode                              = try(each.value.routing_mode, "REGIONAL")
  mtu                                       = try(each.value.mtu, 1460)
  enable_ula_internal_ipv6                  = try(each.value.enable_ula_internal_ipv6, false)
  internal_ipv6_range                       = try(each.value.internal_ipv6_range, "")
  network_firewall_policy_enforcement_order = try(each.value.network_firewall_policy_enforcement_order, "AFTER_CLASSIC_FIREWALL")
  delete_default_routes_on_create           = try(each.value.delete_default_routes_on_create, false)

  lifecycle {
    create_before_destroy = true
  }
}
