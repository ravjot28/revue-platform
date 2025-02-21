variable "subscription_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
  sensitive = true
}

variable "tenant_id" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "environment" {
  type    = string
  validation {
    condition     = contains(["revue-qa", "revue-prod"], var.environment)
    error_message = "Environment must be either 'qa' or 'prod'."
  }
}

variable "trusted_ips" {
  type    = list(string)
  default = []
}
