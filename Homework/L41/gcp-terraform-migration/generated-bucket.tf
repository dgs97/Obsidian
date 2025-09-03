# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "hw-41-bucket"
resource "google_storage_bucket" "hw-41-bucket" {
  default_event_based_hold = false
  enable_object_retention  = false
  force_destroy            = false
  labels                   = {}
  location                 = "US"
  name                     = "hw-41-bucket-clone"
  #project                     = "hw-41-469916"
  public_access_prevention    = "enforced"
  requester_pays              = false
  rpo                         = "DEFAULT"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  soft_delete_policy {
    retention_duration_seconds = 604800
  }
}
