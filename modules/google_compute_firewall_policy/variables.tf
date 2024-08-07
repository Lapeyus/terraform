variable "policies" {
  type = object({
    parent            = string
    short_name        = string
    description       = optional(string)
    attachment_target = optional(string)
    rules = list(
      object({
        action                  = string
        direction               = string
        firewall_policy         = string
        priority                = number
        description             = optional(string)
        disabled                = optional(bool)
        enable_logging          = optional(bool)
        security_profile_group  = optional(string)
        target_resources        = optional(list(string))
        target_service_accounts = optional(list(string))
        tls_inspect             = optional(bool)

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
      })
    )
  })
}
