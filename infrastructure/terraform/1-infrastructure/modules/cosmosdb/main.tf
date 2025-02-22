resource "azurerm_cosmosdb_account" "main" {
  name                = "${var.environment}-cosmos"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = true

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableServerless"
  }

  is_virtual_network_filter_enabled = true

  virtual_network_rule {
    id = var.vnet_subnet_id
  }

  ip_range_filter = join(",", var.trusted_ips)

  tags = var.tags
}

resource "azurerm_cosmosdb_sql_database" "main" {
  name                = "${var.environment}-database"
  resource_group_name = azurerm_cosmosdb_account.main.resource_group_name
  account_name        = azurerm_cosmosdb_account.main.name
}
