output "server_id" {
  value = azurerm_postgresql_flexible_server.main.id
}

output "server_name" {
  value = azurerm_postgresql_flexible_server.main.name
}

output "server_fqdn" {
  value = azurerm_postgresql_flexible_server.main.fqdn
}

output "admin_username" {
  value = azurerm_postgresql_flexible_server.main.administrator_login
}

output "admin_password" {
  value     = var.admin_password != null ? var.admin_password : random_password.postgresql[0].result
  sensitive = true
}