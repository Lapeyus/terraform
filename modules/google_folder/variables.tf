variable "folders" {
  type = map(object({
    name               = optional(string)
    external_parent_id = optional(string)
    parent_entry_key   = optional(string)
    iam                = optional(map(list(string)))
    iam_mode           = optional(string)
  }))
  default = {}
  
  validation {
    condition = alltrue([
      for k, v in var.folders :
      try(v.external_parent_id != null || v.parent_entry_key != null, false)
    ])
    error_message = "Each folder must have either 'external_parent_id' or 'parent_entry_key' defined."
  }
  
  validation {
    condition = alltrue([
      for k, v in var.folders :
      !(v.external_parent_id != null && v.parent_entry_key != null)
    ])
    error_message = "Each folder can have only one of 'external_parent_id' or 'parent_entry_key' defined, not both."
  }
  
  validation {
    condition = alltrue([
      for k, v in var.folders :
      try(
        regex(
          "^[a-zA-Z0-9][a-zA-Z0-9 _-]{0,28}[a-zA-Z0-9]$",
          coalesce(v.name, "")
        ) != null,
        false
      )
    ])
    error_message = "Each folder name must start and end with a letter or digit, may contain letters, digits, spaces, hyphens, and underscores, and can be no longer than 30 characters."
  }
  
  validation {
    condition = alltrue([
      for k, v in var.folders :
      try(
        regex(
          "^(folders/[0-9]+|organizations/[0-9]+)$",
          coalesce(v.external_parent_id, "")
        ) != null,
        v.parent_entry_key != null
      )
    ])
    error_message = "Each folder parent must be of the form 'folders/{folder_id}' or 'organizations/{org_id}'."
  }

  validation {
    condition = length(distinct([for k, v in var.folders : v.name])) == length(var.folders)
    error_message = "Folder display names must be unique within the same level of the hierarchy."
  }

  validation {
    condition = alltrue([
      for k, v in var.folders :
      try(
        length([for fk, fv in var.folders : fv if fv.parent_entry_key == k]) <= 300,
        false
      )
    ])
    error_message = "A parent folder cannot contain more than 300 direct child folders."
  }
  
  validation {
    condition = alltrue([
      for k, v in var.folders :
      try(
        length(
          flatten([
            for pk, pv in var.folders :
            [pk]
            if pk == k || pv.parent_entry_key == k
          ])
        ) <= 9,
        false
      )
    ])
    error_message = "Folders cannot be nested more than 9 levels deep from the root."
  }
}
