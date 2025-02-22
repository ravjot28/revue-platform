variable "subscription_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type      = string
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
  type = string
  validation {
    condition     = contains(["revue-qa", "revue-prod"], var.environment)
    error_message = "Environment must be either 'qa' or 'prod'."
  }
}

variable "trusted_ips" {
  type    = list(string)
  default = []
}

variable "github_username" {
  description = "GitHub username for container registry authentication"
  type        = string
}

variable "github_pat" {
  description = "GitHub Personal Access Token for container registry authentication"
  type        = string
  sensitive   = true
}

variable "github_email" {
  description = "GitHub email for container registry authentication"
  type        = string
}