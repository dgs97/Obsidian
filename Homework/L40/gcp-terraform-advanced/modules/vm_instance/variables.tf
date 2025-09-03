variable "name" {
  description = "Имя виртуальной машины"
  type        = string
}

variable "zone" {
  description = "Зона доступности"
  type        = string
  default     = "europe-west3-a"
}

variable "machine_type" {
  description = "Тип машины"
  type        = string
  default     = "e2-medium"
}

variable "image" {
  description = "Образ ОС"
  type        = string
  default     = "ubuntu-2004-focal-v20240110"
}

variable "network" {
  description = "Имя сети"
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "Имя подсети"
  type        = string
}

variable "tags" {
  description = "Теги сети"
  type        = list(string)
  default     = []
}

variable "service_account" {
  description = "Service account email"
  type        = string
  default     = null
}

variable "metadata" {
  description = "Метаданные инстанса"
  type        = map(string)
  default     = {}
}
