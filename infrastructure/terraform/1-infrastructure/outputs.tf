output "aks_debug" {
  sensitive = true
  value     = module.aks.debug_secret_values
}