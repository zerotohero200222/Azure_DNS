variable "env" {
  type        = string
  description = "Environment name (dev, test, prod)"
}

variable "resource_group_location" {
  type        = string
  description = "Azure region where resources are created"
}

variable "resource_group_name_prefix" {
  type        = string
  description = "Prefix used for the resource group"
}

variable "dns_zone_name" {
  type        = string
  default     = null
  description = "DNS zone name, optional"
}

variable "dns_ttl" {
  type        = number
  description = "Time to live for DNS A record"
}

variable "dns_records" {
  type        = list(string)
  description = "IP addresses for A record"
}

# Backend variables for remote state
variable "backend_resource_group" {}
variable "backend_storage_account" {}
variable "backend_container_name" {}
variable "backend_key" {}
