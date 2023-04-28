folders = {
  "retail" = {
    display_name = "Retail"
    parent       = "folders/247598731200"
    parent_key   = null
  }
  "Riskmgmt" = {
    display_name = "Risk management"
    parent       = "folders/247598731200"
    parent_key   = null
  }
  "Finantial" = {
    display_name = "Finantial"
    parent       = "folders/247598731200"
    parent_key   = null
  }
  "Commercial" = {
    display_name = "Commercial"
    parent       = "folders/247598731200"
    parent_key   = null
  }
  "retail_apps" = {
    display_name = "Apps"
    parent       = null
    parent_key   = "retail"
  }
  "retail_sandbox" = {
    display_name = "Sandbox"
    parent       = null
    parent_key   = "retail"
  }
  "retail_shared" = {
    display_name = "Shared"
    parent       = null
    parent_key   = "retail"
  }
  "Riskmgmt_coreserv" = {
    display_name = "Core Services"
    parent       = null
    parent_key   = "Riskmgmt"
  }
  "Riskmgmt_coreserv" = {
    display_name = "D and A"
    parent       = null
    parent_key   = "Finantial"
  }
  "Commercial_ctrl_serv" = {
    display_name = "Control Services"
    parent       = null
    parent_key   = "Commercial"
  }
}

project_name = "jvillarrealr"
attach_point = "folders/879165398155"
region       = "us-central1"
environments = [
  {
    name            = "dev"
    billing_account = "01E780-7E5C3C-047C23"
    skip_delete     = false
    labels = {
      "env" = "development"
    }
    auto_create_network = false
    services = [
      "compute.googleapis.com",
      "cloudasset.googleapis.com"
    ]
    disable_on_destroy = false
  },
  {
    name            = "prod"
    description     = "This is my network."
    billing_account = "01E780-7E5C3C-047C23"
    skip_delete     = false
    labels = {
      "env" = "production"
    }
    auto_create_network = false
    services = [
      "compute.googleapis.com",
      "cloudasset.googleapis.com"
    ]
    disable_on_destroy = false
  }
]

networks = [
  {
    env                                       = "dev"
    name                                      = "dev-main"
    description                               = "This is a main dev network."
    auto_create_subnetworks                   = false
    routing_mode                              = "REGIONAL"
    mtu                                       = 1460
    enable_ula_internal_ipv6                  = false
    internal_ipv6_range                       = ""
    network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
    delete_default_routes_on_create           = false
  },
  {
    env                                       = "prod"
    name                                      = "prod-main"
    description                               = "This is a prod network."
    auto_create_subnetworks                   = false
    routing_mode                              = "REGIONAL"
    mtu                                       = 1460
    enable_ula_internal_ipv6                  = false
    internal_ipv6_range                       = ""
    network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
    delete_default_routes_on_create           = false
  },
]

sub_networks = [
  {
    name                       = "dev-gke-subnetwork"
    env                        = "dev"
    gcp_region                 = "us-central1"
    network                    = "dev-main"
    subnetwork_cidr            = "10.10.0.0/24" #256
    private_ip_google_access   = true
    private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
    description                = "GKE subnetwork"
    role                       = "ACTIVE"
    stack_type                 = "IPV4_ONLY"
    secondary_ip_range = [
      {
        name          = "gke-pods-range"
        ip_cidr_range = "172.16.0.0/20" #4,096
      },
      {
        name          = "gke-services-range"
        ip_cidr_range = "192.168.1.0/24" #256
      }
    ]
  },
  {
    name                       = "prod-gke-subnetwork"
    env                        = "prod"
    gcp_region                 = "us-central1"
    network                    = "prod-main"
    subnetwork_cidr            = "10.10.0.0/24" #256
    private_ip_google_access   = true
    private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
    description                = "GKE subnetwork"
    role                       = "ACTIVE"
    stack_type                 = "IPV4_ONLY"
    secondary_ip_range = [
      {
        name          = "gke-pods-range"
        ip_cidr_range = "172.16.0.0/20" #4,096
      },
      {
        name          = "gke-services-range"
        ip_cidr_range = "192.168.1.0/24" #256
      }
    ]
  }
]

firewalls = [
  {
    env           = "dev"
    name          = "firewall-1"
    network       = "dev-main"
    priority      = 1000
    direction     = "INGRESS"
    allow         = { protocol = "tcp", ports = ["80", "443"] }
    source_ranges = ["0.0.0.0/0"]
  },
  {
    env           = "prod"
    name          = "firewall-1"
    network       = "prod-main"
    priority      = 1000
    direction     = "INGRESS"
    allow         = { protocol = "tcp", ports = ["80", "443"] }
    source_ranges = ["0.0.0.0/0"]
  },
  #   {
  #     env                     = "dev"
  #     name                    = "firewall-2"
  #     network                 = "dev-main"
  #     priority                = 1000
  #     direction               = "INGRESS"
  #     allow                   = { protocol = "tcp", ports = ["80", "443"] }
  #     source_service_accounts = ["source-service-account@example.iam.gserviceaccount.com"]
  #   },
  #   {
  #     env           = "dev"
  #     name          = "firewall-3"
  #     network       = "dev-main"
  #     priority      = 1000
  #     direction     = "INGRESS"
  #     allow         = { protocol = "tcp", ports = ["80", "443"] }
  #     source_ranges = ["0.0.0.0/0"]
  #   },
  #   {
  #     env         = "prod"
  #     name        = "firewall-4"
  #     network     = "prod-main"
  #     priority    = 1000
  #     direction   = "INGRESS"
  #     allow       = { protocol = "tcp", ports = ["80", "443"] }
  #     target_tags = ["target-tag-1"]
  #   },
  #   {
  #     env                     = "prod"
  #     name                    = "firewall-5"
  #     network                 = "prod-main"
  #     priority                = 1000
  #     direction               = "INGRESS"
  #     allow                   = { protocol = "tcp", ports = ["80", "443"] }
  #     target_service_accounts = ["target-service-account@example.iam.gserviceaccount.com"]
  #   },
]



folder_feed_config = {
  folder       = "247598731200"
  feed_id      = "config-conector-sample"
  content_type = "RESOURCE"
  asset_types = [
    "compute.googleapis.com/Subnetwork",
    "compute.googleapis.com/Network",
  ]
  condition = {
    expression  = <<-EOT
      !temporal_asset.deleted &&
      temporal_asset.prior_asset_state == google.cloud.asset.v1.TemporalAsset.PriorAssetState.DOES_NOT_EXIST
      EOT
    title       = "created"
    description = "Send notifications on creation events"
  }
}