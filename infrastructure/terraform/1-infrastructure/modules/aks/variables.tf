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