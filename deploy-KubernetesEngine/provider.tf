terraform {
    required_providers {
      google = {
          source = "hashicorp/google"
          version = "3.87.0"
      }
    }
}

provider "google" {
    project = var.project
    credentials = file("./service-accounts/probable-drive-327613-5ebce8b44001.json")
  
}