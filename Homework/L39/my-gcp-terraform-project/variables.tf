    variable "gcp_project_id" {
      description = "The ID of the GCP project."
      type        = string
      # default     = "your-gcp-project-id" # Можно указать здесь или применить через gcloud config set project
    }
    
    variable "gcp_region" {
      description = "The GCP region to deploy resources in."
      type        = string
      default     = "europe-central2" # Пример региона, выберите ближайший
    }
    
    variable "instance_type" {
      description = "The machine type for the GCE instance."
      type        = string
      #default     = "e2-micro"
      default     = "e2-small" # Изменили тип инстанса
    }