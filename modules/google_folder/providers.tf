terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.30.0"
    }
  }

  required_version = ">= 1.8.3"
}
