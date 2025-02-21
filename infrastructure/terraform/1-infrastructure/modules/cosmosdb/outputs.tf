output "cosmos_db_id" {
  value = azurerm_cosmosdb_account.main.id
}

output "cosmos_db_endpoint" {
  value = azurerm_cosmosdb_account.main.endpoint
}

output "cosmos_db_primary_key" {
  value     = azurerm_cosmosdb_account.main.primary_key
  sensitive = true
}
