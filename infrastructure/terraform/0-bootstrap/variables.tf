variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "client_id" {
  type        = string
  description = "Azure Service Principal Client ID"
}

variable "client_secret" {
  type        = string
  description = "Azure Service Principal Client Secret"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "eastus2"
}

variable "project" {
  type        = string
  description = "Project Name"
  default     = "mvp"
}