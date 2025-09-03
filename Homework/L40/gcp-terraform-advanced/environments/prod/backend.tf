terraform {
  backend "gcs" {
    bucket = "terraform-state-prod-bucket-12345" # Уникальное имя
    prefix = "terraform/state"
  }
}
