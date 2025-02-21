output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "postgresql_subnet_id" {
  value = azurerm_subnet.postgresql.id
}

output "cosmosdb_subnet_id" {
  value = azurerm_subnet.cosmosdb.id
}
