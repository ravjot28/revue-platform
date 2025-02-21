output "storage_account_name" {
  value = azurerm_storage_account.terraform_state.name
}

output "qa_container_name" {
  value = azurerm_storage_container.terraform_state_qa.name
}

output "prod_container_name" {
  value = azurerm_storage_container.terraform_state_prod.name
}

output "resource_group_name" {
  value = azurerm_resource_group.terraform_state.name
}