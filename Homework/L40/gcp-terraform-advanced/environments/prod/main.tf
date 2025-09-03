module "web_server" {
  source = "../../modules/vm_instance"

  name         = "web-server-prod"
  zone         = "europe-west3-a"
  machine_type = "e2-medium"
  image        = "ubuntu-2004-focal-v20240110"
  network      = google_compute_network.vpc_network.name
  subnetwork   = google_compute_subnetwork.subnet.name
  tags         = ["http-server", "https-server"]

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

module "db_server" {
  source = "../../modules/vm_instance"

  name         = "db-server-prod"
  zone         = "europe-west3-a"
  machine_type = "e2-standard-2"
  image        = "ubuntu-2004-focal-v20240110"
  network      = google_compute_network.vpc_network.name
  subnetwork   = google_compute_subnetwork.subnet.name
  tags         = ["internal"]

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

# VPC Network
resource "google_compute_network" "vpc_network" {
  name                    = "prod-vpc-network"
  auto_create_subnetworks = false
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "prod-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west3"
  network       = google_compute_network.vpc_network.id
}

# Firewall rule for HTTP
resource "google_compute_firewall" "http" {
  name    = "allow-http"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]

  # Явная зависимость от создания сети
  depends_on = [google_compute_network.vpc_network]
}

# Firewall rule for HTTPS
resource "google_compute_firewall" "https" {
  name    = "allow-https"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]

  depends_on = [google_compute_network.vpc_network]
}

# Firewall rule for SSH
resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]

  depends_on = [google_compute_network.vpc_network]
}

# Internal firewall rule (only from within VPC)
resource "google_compute_firewall" "internal" {
  name    = "allow-internal"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.0.1.0/24"]
  target_tags   = ["internal"]

  depends_on = [google_compute_network.vpc_network]
}
