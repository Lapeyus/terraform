output "firewall_rules" {
  value = {
    for k, v in google_compute_firewall.firewall :
    k => {
      id                      = v.id
      name                    = v.name
      project                 = v.project
      network                 = v.network
      priority                = v.priority
      description             = v.description
      destination_ranges      = v.destination_ranges
      direction               = v.direction
      disabled                = v.disabled
      source_ranges           = v.source_ranges
      source_service_accounts = v.source_service_accounts
      source_tags             = v.source_tags
      target_service_accounts = v.target_service_accounts
      target_tags             = v.target_tags
      allow                   = v.allow
      deny                    = v.deny
      log_config              = v.log_config
    }
  }
}

output "firewall_ids" {
  value = { for k, v in google_compute_firewall.firewall : k => v.id }
}

output "firewall_names" {
  value = { for k, v in google_compute_firewall.firewall : k => v.name }
}
