# attach_point
variable "attach_point" {
  type = string
}

variable "project_name" {
  type = string
}

variable "random_id" {
  type = string
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

