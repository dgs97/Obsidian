variable "gcp_project_id" {
  description = "The ID of the GCP project."
  type        = string
  default     = "hw-41-clone" # Можно указать здесь или применить через gcloud config set project
}

variable "gcp_region" {
  description = "The GCP region to deploy resources in."
  type        = string
  default     = "europe-west1" # Пример региона, выберите ближайший
}
