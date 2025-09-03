terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.33.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id # Будет определено в variables.tf
  region  = var.gcp_region     # Будет определено в variables.tf
}

#Импорт двух виртуалок
#import {
#  id = "projects/hw-41-469916/zones/us-central1-a/instances/my-vm"
#  to = google_compute_instance.my-vm
#}

#import {
#  id = "projects/hw-41-469916/zones/us-central1-a/instances/my-vm"
#  to = google_compute_instance.my-vm2
#}

#Импорт бакета
#import {
#  id = "hw-41-bucket"
#  to = google_storage_bucket.hw-41-bucket
#}


