# --- 1. СЕТЬ И ПОДСЕТЬ ---
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

resource "google_compute_network" "jenkins_vpc" {
  name                    = "vpc-jenkins-agents"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "jenkins_subnet" {
  name          = "subnet-jenkins-agents"
  ip_cidr_range = "10.10.10.0/24"
  region        = var.gcp_region
  network       = google_compute_network.jenkins_vpc.id
}

# --- 2. ПРАВИЛА ФАЙРВОЛА ---
resource "google_compute_firewall" "allow_egress" {
  name    = "fw-jenkins-allow-egress"
  network = google_compute_network.jenkins_vpc.id
  allow {
    protocol = "all"
  }
  direction     = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "fw-jenkins-allow-ssh-from-trusted"
  network = google_compute_network.jenkins_vpc.id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  direction = "INGRESS"
  source_ranges = var.trusted_ssh_ips
  # Правило применяется только к VM с этим тегом
  target_tags = ["jenkins-agent"]
}

# --- 3. IAM И СЕРВИСНЫЙ АККАУНТ ---
resource "google_service_account" "jenkins_agent_sa" {
  account_id   = "jenkins-agent-sa"
  display_name = "Service Account for Jenkins Agents"
}

# Даем сервисному аккаунту права на просмотр ресурсов и запись логов
resource "google_project_iam_member" "jenkins_agent_viewer" {
  project = var.gcp_project_id
  role    = "roles/viewer"
  member  = "serviceAccount:${google_service_account.jenkins_agent_sa.email}"
}

resource "google_project_iam_member" "jenkins_agent_logwriter" {
  project = var.gcp_project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.jenkins_agent_sa.email}"
}

# --- 4. ВИРТУАЛЬНАЯ МАШИНА АГЕНТА ---
resource "google_compute_instance" "jenkins_agent" {
  project      = var.gcp_project_id
  zone         = var.gcp_zone
  name         = var.agent_name
  machine_type = "e2-small"
  tags         = ["jenkins-agent"]
  labels = {
    purpose = "jenkins-agent"
  }

  scheduling {
    provisioning_model          = "SPOT"
    instance_termination_action = "DELETE"
    on_host_maintenance         = "TERMINATE"
    automatic_restart           = false 
    preemptible                 = true
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.jenkins_subnet.id
    access_config {}
  }

  service_account {
    email  = google_service_account.jenkins_agent_sa.email
    scopes = []
  }

# --- НАСТРОЙКА SSH И ЗАПУСКА ---
  metadata = {
    # Отключаем OS Login, чтобы заработали ключи из ssh-keys
    enable-oslogin = "FALSE" # <-- Главное изменение

    # Передаем ОБА ключа (для Jenkins и для вас)
    ssh-keys = <<-EOT
      devops:${var.jenkins_public_key}
      nikolos:${file("~/.ssh/id_rsa.pub")}
    EOT
    
    # Скрипт для установки Java остается без изменений
    startup-script = <<-EOT
      #!/bin/bash
      apt-get update
      apt-get install -y openjdk-17-jdk
    EOT
  }
}