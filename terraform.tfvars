env                         = "dev"
resource_group_location     = "eastus2"
resource_group_name_prefix  = "dnsrg"
dns_zone_name               = null
dns_ttl                     = 300
dns_records                 = ["192.168.1.1", "192.168.1.2"]

backend_resource_group      = "tfstate-rg"
backend_storage_account     = "tfstate123dev"
backend_container_name      = "tfstate"
backend_key                 = "dev/terraform.tfstate"

