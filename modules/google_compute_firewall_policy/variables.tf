variable "rules" {
  type = object({
    parent      = string
    short_name  = string
    description = optional(string)
    rules = list(
      object({
        project                 = string
        name                    = string
        network                 = string
        priority                = number
        description             = optional(string)
        destination_ranges      = optional(list(string))
        direction               = string
        disabled                = optional(bool)
        source_ranges           = optional(list(string))
        source_service_accounts = optional(list(string))
        source_tags             = optional(list(string))
        target_service_accounts = optional(list(string))
        target_tags             = optional(list(string))
        allow = optional(list(object({
          protocol = string
          ports    = optional(list(string))
        })))
        deny = optional(list(object({
          protocol = string
          ports    = optional(list(string))
        })))
        metadata = optional(string)
        log_config = optional(object({
          metadata = string
        }))
        action          = string
        firewall_policy = string
        match = object({
          dest_address_groups       = optional(list(string))
          dest_fqdns                = optional(list(string))
          dest_ip_ranges            = optional(list(string))
          dest_region_codes         = optional(list(string))
          dest_threat_intelligences = optional(list(string))
          layer4_configs = list(object({
            ip_protocol = string
            ports       = optional(list(string))
          }))
          src_address_groups       = optional(list(string))
          src_fqdns                = optional(list(string))
          src_ip_ranges            = optional(list(string))
          src_region_codes         = optional(list(string))
          src_threat_intelligences = optional(list(string))
        })
        enable_logging         = optional(bool)
        security_profile_group = optional(string)
        target_resources       = optional(list(string))
        tls_inspect            = optional(bool)
      })
    )
  })
  default = {
    parent      = ""
    short_name  = ""
    description = null
    rules       = []
  }
}
