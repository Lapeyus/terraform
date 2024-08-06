variable "rules" {
  type = list(object({
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
    allow                   = optional(object({ protocol = string, ports = list(string) }))
    deny                    = optional(object({ protocol = string, ports = list(string) }))
    metadata                = optional(string)
    log_config = optional(object({
      metadata = string
    }))
  }))
  default = []

  validation {
    condition = alltrue([for fw in var.rules : (
      fw.name != null && length(fw.name) >= 1 && length(fw.name) <= 63 &&
      can(
        regex("[a-z]([-a-z0-9]*[a-z0-9])?", fw.name)
      ) &&
      (
        fw.direction == "INGRESS" ||
        fw.direction == "EGRESS"
      ) &&
      (
        fw.disabled == true ||
        fw.disabled == false ||
        fw.disabled == null
      ) &&
      fw.priority >= 0 && fw.priority <= 65535 &&
      (
        fw.log_config == null ||
        fw.log_config.metadata == "EXCLUDE_ALL_METADATA" ||
        fw.log_config.metadata == "INCLUDE_ALL_METADATA"
      ) &&
      (
        fw.network != "prod" || alltrue(
          [for sr in fw.source_ranges : sr != "0.0.0.0/0"]
        )
      ) &&
      (
        fw.network != "dev" || alltrue(
          [for sr in fw.source_ranges : sr != "10.0.0.0/0"],
          [for sr in fw.source_ranges : sr != "10.10.0.0/0"]
        )
      )
    )])
    error_message = "Validation error: Ensure 'name' is specified, 1-63 characters long, matches the pattern '[a-z]([-a-z0-9]*[a-z0-9])?', 'direction' is either 'INGRESS' or 'EGRESS', 'disabled' is either true or false, 'priority' is an integer between 0 and 65535, 'log_config.metadata' is either 'EXCLUDE_ALL_METADATA' or 'INCLUDE_ALL_METADATA' if provided, and 'source_ranges' does not include '0.0.0.0/0' if 'network' is 'prod'."
  }
}
