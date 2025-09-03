output "instance_id" {
  description = "ID созданной виртуальной машины"
  value       = google_compute_instance.vm.id
}

output "instance_name" {
  description = "Имя виртуальной машины"
  value       = google_compute_instance.vm.name
}

output "internal_ip" {
  description = "Внутренний IP адрес"
  value       = google_compute_instance.vm.network_interface[0].network_ip
}

output "external_ip" {
  description = "Внешний IP адрес"
  value       = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}

output "self_link" {
  description = "Self link инстанса"
  value       = google_compute_instance.vm.self_link
}
