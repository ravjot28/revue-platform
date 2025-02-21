variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "vnet_subnet_id" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "trusted_ips" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "admin_username" {
  type    = string
  default = "psqladmin"
}

variable "admin_password" {
  type        = string
  description = "If not provided, a random password will be generated"
  default     = null
  sensitive   = true
}