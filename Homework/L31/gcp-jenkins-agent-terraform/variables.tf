variable "gcp_project_id" {
  type        = string
  description = "ID вашего проекта в Google Cloud."
}

variable "gcp_region" {
  type        = string
  description = "Регион для создания ресурсов."
  default     = "us-central1"
}

variable "gcp_zone" {
  type        = string
  description = "Зона для создания VM."
  default     = "us-central1-a"
}

variable "agent_name" {
  type        = string
  description = "Уникальное имя для Jenkins агента (должно совпадать с именем узла в Jenkins)."
  default     = "gce-debian-agent-01"
}

variable "trusted_ssh_ips" {
  type        = list(string)
  description = "Список IP-адресов в формате CIDR, с которых разрешен доступ по SSH."
  default     = ["0.0.0.0/0"]
}
variable "jenkins_public_key" {
  type        = string
  description = "Содержимое публичного SSH-ключа для Jenkins агента."
  sensitive   = true # Скрываем ключ в логах
}