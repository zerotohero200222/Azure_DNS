variable "env" {
  type        = string
  description = "Environment name (e.g., dev, test, prod)."
}

variable "resource_group_location" {
  type        = string
  description = "Location for all resources."
}

variable "resource_group_name_prefix" {
  type        = string
  description = "Prefix for the resource group name."
}

variable "dns_zone_name" {
  type        = string
  default     = null
  description = "Optional DNS zone name."
}

variable "dns_ttl" {
  type        = number
  description = "Time To Live (TTL) for the DNS record."
}

variable "dns_records" {
  type        = list(string)
  description = "List of IP addresses for the A record."
}
