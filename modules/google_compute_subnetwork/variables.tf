variable "random_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "sub_networks" {
  type = list(object({
    name                       = string
    env                        = string
    network                    = string
    subnetwork_cidr            = string
    private_ip_google_access   = bool
    private_ipv6_google_access = optional(string)
    description                = optional(string)
    purpose                    = optional(string)
    role                       = optional(string)
    stack_type                 = optional(string)
    ipv6_access_type           = optional(string)
    gcp_region                 = string
    secondary_ip_range = optional(list(object({
      name          = string
      ip_cidr_range = string
    })))
    log_config = optional(object({
      aggregation_interval = optional(string)
      flow_sampling        = optional(string)
      metadata             = optional(string)
      metadata_fields      = optional(list(string))
      filter_expr          = optional(string)
    }))
  }))
  default     = []
  description = "A list of subnetwork configurations."
}

