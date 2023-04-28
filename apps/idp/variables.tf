# global
variable "attach_point" {
  type    = string
  default = "My Project"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "project_name" {
  type    = string
  default = "My Project"
}

variable "environments" {
  type = list(object({
    name                       = string
    billing_account            = optional(string)
    skip_delete                = optional(bool)
    labels                     = optional(map(string))
    auto_create_network        = optional(bool)
    services                   = optional(list(string))
    disable_dependent_services = optional(bool)
    disable_on_destroy         = optional(bool)
  }))
  default = []
}

variable "networks" {
  type = list(object({
    name                                      = string
    env                                       = string
    description                               = optional(string)
    auto_create_subnetworks                   = optional(bool)
    routing_mode                              = optional(string)
    mtu                                       = optional(number)
    enable_ula_internal_ipv6                  = optional(bool)
    internal_ipv6_range                       = optional(string)
    network_firewall_policy_enforcement_order = optional(string)
    delete_default_routes_on_create           = optional(bool)
  }))
  default = []
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

variable "firewalls" {
  type = list(object({
    env                     = string
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
  }))
}


variable "folders" {
  type = map(object({
    display_name = string
    parent       = string
    parent_key   = string
  }))
  default = {}
}

variable "folder_feed_config" {
  type = object({
    folder : string
    feed_id : string
    content_type : string
    asset_types : optional(list(string))
    condition : optional(object({
      expression : string
      title : optional(string)
      description : optional(string)
    }))
  })
}