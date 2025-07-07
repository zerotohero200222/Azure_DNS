resource "random_pet" "rg_name" {
  prefix = "${var.resource_group_name_prefix}-${var.env}"
}

resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg_name.id
  location = var.resource_group_location
  tags = {
    environment = var.env
  }
}

resource "random_string" "azurerm_dns_zone_name" {
  length  = 13
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_dns_zone" "zone" {
  name = (
    var.dns_zone_name != null ?
    var.dns_zone_name :
    "www.${random_string.azurerm_dns_zone_name.result}.${var.env}.azurequickstart.org"
  )
  resource_group_name = azurerm_resource_group.rg.name
  tags = {
    environment = var.env
  }
}

resource "azurerm_dns_a_record" "record" {
  name                = "www"
  resource_group_name = azurerm_resource_group.rg.name
  zone_name           = azurerm_dns_zone.zone.name
  ttl                 = var.dns_ttl
  records             = var.dns_records
  tags = {
    environment = var.env
  }
}
