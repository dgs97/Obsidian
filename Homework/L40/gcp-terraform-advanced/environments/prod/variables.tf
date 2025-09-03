variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "hw-40-469515"
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "europe-west3"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "europe-west3-a"
}

variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default     = "~/.config/gcloud/application_default_credentials.json"
}
