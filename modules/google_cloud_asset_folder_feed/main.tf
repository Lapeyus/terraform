# resource "google_cloud_asset_folder_feed" "folder_feed" {
#   folder       = var.folder_feed_config.folder
#   content_type = var.folder_feed_config.content_type
#   feed_id      = var.folder_feed_config.feed_id

#   asset_types     = try(var.folder_feed_config.asset_types, [])
#   billing_project = "01E780-7E5C3C-047C23"

#   feed_output_config {
#     pubsub_destination {
#       topic = google_pubsub_topic.feed_output.id
#     }
#   }

#   dynamic "condition" {
#     for_each = try(var.folder_feed_config.condition, []) != [] ? [var.folder_feed_config.condition] : []

#     content {
#       expression  = condition.value.expression
#       title       = try(condition.value.title, "")
#       description = try(condition.value.description, "")
#     }
#   }
# }

# The topic where the resource change notifications will be sent.
resource "google_pubsub_topic" "feed_output" {
  project = var.project_name
  name    = "cloud-asset-project-feed"
}


# resource "google_cloud_asset_organization_feed" "organization_feed" {}
# resource "google_cloud_asset_folder_feed" "folder_feed" {}
# resource "google_cloud_asset_project_feed" "project_feed" {}