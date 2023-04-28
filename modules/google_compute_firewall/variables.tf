variable "random_id" {
  type = string
}

variable "project_name" {
  type = string
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
  default = []
}


variable "clusters" {
  type    = list(object({}))
  default = []
}