variable "random_id" {
  type = string
}

variable "project_name" {
  type = string
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



