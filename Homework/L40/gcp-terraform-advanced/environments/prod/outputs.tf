output "web_server_ip" {
  description = "Public IP веб-сервера"
  value       = module.web_server.external_ip
}

output "db_server_internal_ip" {
  description = "Internal IP базы данных"
  value       = module.db_server.internal_ip
}

output "vpc_network_name" {
  description = "Имя VPC сети"
  value       = google_compute_network.vpc_network.name
}

output "subnet_name" {
  description = "Имя подсети"
  value       = google_compute_subnetwork.subnet.name
}
