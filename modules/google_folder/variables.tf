variable "folders" {
  type = map(object({
    name               = optional(string)
    external_parent_id = optional(string)
    parent_entry_key   = optional(string)
    iam                = optional(map(list(string)))
    iam_mode           = optional(string)
  }))
  default = {}
}

