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

resource "random_string" "zone" {
  length  = 10
  upper   = false
  numeric = false
  special = false
}

resource "azurerm_dns_zone" "zone" {
  name = var.dns_zone_name != null ?
         var.dns_zone_name :
         "www.${random_string.zone.result}.${var.env}.example.org"

  resource_group_name = azurerm_resource_group.rg.name
  tags = {
    environment = var.env
  }
}

resource "azurerm_dns_a_record" "record" {
  name                = "www"
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = var.dns_ttl
  records             = var.dns_records

  tags = {
    environment = var.env
  }
}
