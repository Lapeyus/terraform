# output "subnetworks" {
#   value = {
#     for subnet in google_compute_subnetwork.gke : subnet.name => {
#       name                       = subnet.name
#       region                     = subnet.region
#       network                    = subnet.network
#       ip_cidr_range              = subnet.ip_cidr_range
#       private_ip_google_access   = subnet.private_ip_google_access
#       private_ipv6_google_access = subnet.private_ipv6_google_access
#       project                    = subnet.project
#       description                = subnet.description
#       purpose                    = subnet.purpose
#       role                       = subnet.role
#       stack_type                 = subnet.stack_type
#       ipv6_access_type           = subnet.ipv6_access_type
#       secondary_ip_range = [
#         for range in subnet.secondary_ip_range : {
#           range_name    = range.range_name
#           ip_cidr_range = range.ip_cidr_range
#         }
#       ]
#       log_config = {
#         # aggregation_interval = subnet.log_config.aggregation_interval
#         flow_sampling        = subnet.log_config.flow_sampling
#         metadata             = subnet.log_config.metadata
#         metadata_fields      = subnet.log_config.metadata_fields
#         # filter_expr          = subnet.log_config.filter_expr
#       }
#     }
#   }
#   description = "A map of created subnetworks and their attributes."
# }
