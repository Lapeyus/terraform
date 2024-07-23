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

variable "project_name" {
  type = string
}
