# modules/postgresql/main.tf

# First, declare the data source for VNET
data "azurerm_virtual_network" "vnet" {
  name                = split("/", var.vnet_subnet_id)[8]
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "postgresql" {
  name                  = "private.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgresql" {
  name                  = "${var.environment}-postgresql-link"
  private_dns_zone_name = azurerm_private_dns_zone.postgresql.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
}

data "azurerm_subnet" "postgresql" {
  name                 = split("/", var.vnet_subnet_id)[10]
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group_name
}

resource "random_password" "postgresql" {
  count            = var.admin_password == null ? 1 : 0
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_postgresql_flexible_server" "main" {
  name                = "${var.environment}-postgresql"
  resource_group_name = var.resource_group_name
  location            = var.location
  version            = "14"

  administrator_login    = var.admin_username
  administrator_password = var.admin_password != null ? var.admin_password : random_password.postgresql[0].result

  storage_mb = var.environment == "revue-prod" ? 65536 : 32768
  sku_name   = var.sku_name

  backup_retention_days        = var.environment == "revue-prod" ? 30 : 7
  geo_redundant_backup_enabled = var.environment == "revue-prod"

  # VNET integration settings
  delegated_subnet_id = var.vnet_subnet_id
  private_dns_zone_id = azurerm_private_dns_zone.postgresql.id

  # Explicitly disable public network access
  public_network_access_enabled = false
  zone                          = "1"

  maintenance_window {
    day_of_week  = 0
    start_hour   = 0
    start_minute = 0
  }

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.postgresql
  ]

  tags = var.tags
}

# Create default database
resource "azurerm_postgresql_flexible_server_database" "default" {
  name      = "default"
  server_id = azurerm_postgresql_flexible_server.main.id
  collation = "en_US.utf8"
  charset   = "utf8"
}