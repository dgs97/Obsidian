# Define the Google Cloud provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.33.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# ---
## Настройка сети и брандмауэра

# Use the custom VPC network
resource "google_compute_network" "my_custom_network" {
  name = "my-web-server-network"
}

# Allow incoming HTTP traffic
resource "google_compute_firewall" "http_traffic" {
  name    = "allow-http-traffic"
  network = google_compute_network.my_custom_network.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# ---
## Определение и развертывание веб-сервера

# Create a Compute Engine instance
resource "google_compute_instance" "web_server_instance" {
  name         = "web-server"
  machine_type = var.instance_type
  zone         = var.zone

  # Use a public Debian image
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  # Attach a public IP to the instance
  network_interface {
    network = google_compute_network.my_custom_network.name
    access_config {
      // Ephemeral IP
    }
  }

  # Startup script to install and run Nginx
  metadata = {
    startup-script = <<-EOT
      #!/bin/bash
      apt-get update
      apt-get install -y nginx
      echo "<h1>Welcome to my Terraform-powered website!</h1>" > /var/www/html/index.nginx-debian.html
      systemctl start nginx
      systemctl enable nginx
    EOT
  }

  tags = ["http-server"]
}
