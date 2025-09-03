output "agent_ip" {
  description = "Внешний IP-адрес Jenkins агента"
  value       = google_compute_instance.jenkins_agent.network_interface[0].access_config[0].nat_ip
}