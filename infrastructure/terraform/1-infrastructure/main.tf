resource "azurerm_resource_group" "main" {
  name     = "${var.environment}-rg"
  location = var.location
  tags     = local.tags
}

module "networking" {
  source              = "./modules/networking"
  resource_group_name = azurerm_resource_group.main.name
  location           = var.location
  environment        = var.environment
  tags               = local.tags
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.main.name
  location           = var.location
  environment        = var.environment
  vnet_subnet_id     = module.networking.aks_subnet_id
  node_sizes         = local.env_configs[var.environment].aks_vm_size
  tags               = local.tags
}

module "postgresql" {
  source              = "./modules/postgresql"
  resource_group_name = azurerm_resource_group.main.name
  location           = var.location
  environment        = var.environment
  vnet_subnet_id     = module.networking.postgresql_subnet_id
  sku_name           = local.env_configs[var.environment].postgresql_sku
  trusted_ips        = var.trusted_ips
  tags               = local.tags
}

module "cosmosdb" {
  source              = "./modules/cosmosdb"
  resource_group_name = azurerm_resource_group.main.name
  location           = var.location
  environment        = var.environment
  vnet_subnet_id     = module.networking.cosmosdb_subnet_id
  trusted_ips        = var.trusted_ips
  tags               = local.tags
}
