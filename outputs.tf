output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "dns_zone_name" {
  value = azurerm_dns_zone.zone.name
}

output "dns_name_servers" {
  value = azurerm_dns_zone.zone.name_servers
}
