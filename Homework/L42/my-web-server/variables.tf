variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone to deploy the VM"
  type        = string
  default     = "us-central1-a"
}

variable "instance_type" {
  description = "The type of the VM instance"
  type        = string
  default     = "e2-medium"
}
