resource "random_string" "storage_account_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "terraform_state" {
  name     = "${var.project}-tfstate-rg"
  location = var.location
  tags = {
    Project     = var.project
    Purpose     = "Terraform State Management"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_storage_account" "terraform_state" {
  name                            = "${var.project}tfstate${random_string.storage_account_suffix.result}"
  resource_group_name             = azurerm_resource_group.terraform_state.name
  location                        = azurerm_resource_group.terraform_state.location
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  allow_nested_items_to_be_public = false
  min_tls_version                = "TLS1_2"

  blob_properties {
    versioning_enabled = true
    
    container_delete_retention_policy {
      days = 7
    }

    delete_retention_policy {
      days = 7
    }
  }

  tags = azurerm_resource_group.terraform_state.tags
}

# Create separate containers for QA and PROD states
resource "azurerm_storage_container" "terraform_state_qa" {
  name                  = "tfstate-qa"
  storage_account_name  = azurerm_storage_account.terraform_state.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "terraform_state_prod" {
  name                  = "tfstate-prod"
  storage_account_name  = azurerm_storage_account.terraform_state.name
  container_access_type = "private"
}
