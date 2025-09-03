# Укажите необходимую версию провайдера Google
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.45.0" # Используйте актуальную версию
    }
  }
}

provider "google" {
  project = var.gcp_project_id # Будет определено в variables.tf
  region  = var.gcp_region      # Будет определено в variables.tf
}
# Пример создания виртуальной машины GCE
resource "google_compute_instance" "example_vm" {
  name         = "my-terraform-instance"
  machine_type = var.instance_type # Используем переменную
  zone         = "${var.gcp_region}-a" # Пример зоны в регионе
  allow_stopping_for_update = true  # ✅ Разрешить остановку

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" # Пример образа
    }
  }

  network_interface {
    network = "default" # Используем сеть по умолчанию
  }

  metadata_startup_script = "echo 'Hello from Terraform on GCP!' | tee /var/log/startup.log"
}

# Пример создания Cloud Storage Bucket
resource "google_storage_bucket" "example_bucket" {
  name          = "my-terraform-bucket-${random_id.bucket_suffix.hex}" # Уникальное имя
  location      = var.gcp_region
  storage_class = "STANDARD"
  force_destroy = true # Удалит содержимое при удалении бакета Terraform
}

# Для создания уникального имени бакета
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

#Создание брандмауэра
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-ingress-terraform"
  network = "default" # Применяем к сети по умолчанию

  allow {
    protocol = "tcp"
    ports    = ["80"] # Разрешаем HTTP
  }

  source_ranges = ["0.0.0.0/0"] # Разрешить трафик отовсюду
  description   = "Allow incoming HTTP traffic for Terraform managed VMs"
}

