resource "google_compute_instance" "vm" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size  = 20
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {
      // Ephemeral public IP
    }
  }

  tags = var.tags

  service_account {
    email  = var.service_account
    scopes = ["cloud-platform"]
  }

  metadata = var.metadata

  lifecycle {
    create_before_destroy = true
  }
}
