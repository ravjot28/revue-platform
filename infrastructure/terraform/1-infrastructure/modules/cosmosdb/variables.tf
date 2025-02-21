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

variable "trusted_ips" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}