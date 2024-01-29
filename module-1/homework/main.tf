terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}


provider "google" {
  credentials = "./keys/my-project-de-zoomcamp-412417-b8c1f6f19746.json"
  project     = "my-project-de-zoomcamp-412417"
  region      = "us-central1"
}



resource "google_storage_bucket" "data-lake-bucket" {
  name          = "my-project-de-zoomcamp-412417-bucket"
  location      = "US"

  # Optional, but recommended settings:
  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30  // days
    }
  }

  force_destroy = true
}


resource "google_bigquery_dataset" "dataset" {
  dataset_id = "demo_dataset"
  project    = "my-project-de-zoomcamp-412417"
  location   = "US"
}