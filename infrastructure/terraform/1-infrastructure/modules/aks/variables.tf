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

variable "node_sizes" {
  type = object({
    cpu = string
    mem = string
  })
}

variable "tags" {
  type = map(string)
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