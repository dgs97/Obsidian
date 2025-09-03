# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "projects/hw-41-469916/zones/us-central1-a/instances/my-vm"
resource "google_compute_instance" "my-vm" {
  allow_stopping_for_update = null
  can_ip_forward            = false
  deletion_protection       = false
  description               = null
  desired_status            = null
  enable_display            = false
  guest_accelerator         = []
  hostname                  = null
  labels                    = {}
  machine_type              = "e2-micro"
  metadata                  = {}
  metadata_startup_script   = null
  min_cpu_platform          = null
  name                      = "my-vm"
  project                   = null # Убрана привязка к конкретному проекту
  resource_policies         = []
  tags                      = ["http-server"]
  zone                      = "us-central1-a"

  boot_disk {
    auto_delete             = true
    device_name             = "persistent-disk-0"
    disk_encryption_key_raw = null # sensitive
    kms_key_self_link       = null
    mode                    = "READ_WRITE"
    source                  = null # Убрана привязка к конкретному диску

    initialize_params {
      enable_confidential_compute = false
      image                       = "debian-11-bullseye-v20250812" # Короткое имя вместо полного URL
      labels                      = {}
      provisioned_iops            = 0
      provisioned_throughput      = 0
      resource_manager_tags       = {}
      size                        = 10
      type                        = "pd-standard"
    }
  }

  network_interface {
    internal_ipv6_prefix_length = 0
    ipv6_address                = null
    network                     = "default" # Короткое имя вместо полного URL
    network_ip                  = null      # Автоматическое назначение IP
    nic_type                    = null
    queue_count                 = 0
    stack_type                  = "IPV4_ONLY"
    subnetwork                  = "default" # Короткое имя вместо полного URL
    subnetwork_project          = null      # Убрана привязка к конкретному проекту

    access_config {
      nat_ip                 = null # Автоматическое назначение внешнего IP
      network_tier           = "PREMIUM"
      public_ptr_domain_name = null
    }
  }

  scheduling {
    automatic_restart           = true
    instance_termination_action = null
    min_node_cpus               = 0
    on_host_maintenance         = "MIGRATE"
    preemptible                 = false
    provisioning_model          = "STANDARD"
  }

  service_account {
    email  = null # Будет использоваться сервисный аккаунт по умолчанию
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/pubsub", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }
}

# __generated__ by Terraform from "projects/hw-41-469916/zones/us-central1-a/instances/my-vm"
resource "google_compute_instance" "my-vm2" {
  allow_stopping_for_update = null
  can_ip_forward            = false
  deletion_protection       = false
  description               = null
  desired_status            = null
  enable_display            = false
  guest_accelerator         = []
  hostname                  = null
  labels                    = {}
  machine_type              = "e2-micro"
  metadata                  = {}
  metadata_startup_script   = null
  min_cpu_platform          = null
  name                      = "my-vm2" # Изменено имя для избежания конфликта
  project                   = null     # Убрана привязка к конкретному проекту
  resource_policies         = []
  tags                      = ["http-server"]
  zone                      = "us-central1-a"

  boot_disk {
    auto_delete             = true
    device_name             = "persistent-disk-0"
    disk_encryption_key_raw = null # sensitive
    kms_key_self_link       = null
    mode                    = "READ_WRITE"
    source                  = null # Убрана привязка к конкретному диску

    initialize_params {
      enable_confidential_compute = false
      image                       = "debian-11-bullseye-v20250812" # Короткое имя вместо полного URL
      labels                      = {}
      provisioned_iops            = 0
      provisioned_throughput      = 0
      resource_manager_tags       = {}
      size                        = 10
      type                        = "pd-standard"
    }
  }

  network_interface {
    internal_ipv6_prefix_length = 0
    ipv6_address                = null
    network                     = "default" # Короткое имя вместо полного URL
    network_ip                  = null      # Автоматическое назначение IP
    nic_type                    = null
    queue_count                 = 0
    stack_type                  = "IPV4_ONLY"
    subnetwork                  = "default" # Короткое имя вместо полного URL
    subnetwork_project          = null      # Убрана привязка к конкретному проекту

    access_config {
      nat_ip                 = null # Автоматическое назначение внешнего IP
      network_tier           = "PREMIUM"
      public_ptr_domain_name = null
    }
  }

  scheduling {
    automatic_restart           = true
    instance_termination_action = null
    min_node_cpus               = 0
    on_host_maintenance         = "MIGRATE"
    preemptible                 = false
    provisioning_model          = "STANDARD"
  }

  service_account {
    email  = null # Будет использоваться сервисный аккаунт по умолчанию
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/pubsub", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }
}
