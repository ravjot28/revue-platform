locals {
  # Environment-specific configurations
  env_configs = {
    revue-qa = {
      aks_vm_size = {
        cpu = "Standard_F4s_v2"
        mem = "Standard_E4s_v3"
      }
      postgresql_sku = "GP_Standard_D2s_v3"
    }
    revue-prod = {
      aks_vm_size = {
        cpu = "Standard_F8s_v2"
        mem = "Standard_E8s_v3"
      }
      postgresql_sku = "GP_Standard_D4s_v3"
    }
  }

  # Common tags
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
