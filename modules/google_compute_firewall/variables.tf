variable "firewalls" {
  type = list(object({
    project                 = string
    name                    = string
    network                 = string
    allow                   = optional(object({ metadata = string, ports = list(string) }))
    deny                    = optional(object({ protocol = string, ports = list(string) }))
    description             = optional(string)
    destination_ranges      = optional(list(string))
    direction               = string
    disabled                = optional(bool)
    log_config              = optional(object({ metadata = string }))
    priority                = number
    source_ranges           = optional(list(string))
    source_service_accounts = optional(list(string))
    source_tags             = optional(list(string))
    target_service_accounts = optional(list(string))
    target_tags             = optional(list(string))
  }))
  default = []

  validation {
    condition = alltrue([for fw in var.firewalls : (
      fw.name != null &&
      length(fw.name) >= 1 &&
      length(fw.name) <= 63 &&
      can(regex("[a-z]([-a-z0-9]*[a-z0-9])?", fw.name)) &&
      (fw.direction == "INGRESS" || fw.direction == "EGRESS")
    )])
    error_message = "Validation error: Ensure 'name' is specified, 1-63 characters long, matches the pattern '[a-z]([-a-z0-9]*[a-z0-9])?', and 'direction' is either 'INGRESS' or 'EGRESS'."
  }
}
