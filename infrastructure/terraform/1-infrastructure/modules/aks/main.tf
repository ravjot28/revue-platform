resource "azurerm_kubernetes_cluster" "main" {
  name                = "${var.environment}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.environment}-aks"
#  kubernetes_version  = "1.27"

  default_node_pool {
    name                = "system"
    node_count          = 1
    vm_size             = "Standard_D2s_v3"
    vnet_subnet_id      = var.vnet_subnet_id
    only_critical_addons_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    service_cidr   = "172.16.0.0/16"
    dns_service_ip = "172.16.0.10"
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "cpu" {
  name                  = "cpupool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size              = var.node_sizes.cpu
  enable_auto_scaling  = true
  min_count           = 0
  max_count           = 3
  vnet_subnet_id      = var.vnet_subnet_id

  node_labels = {
    "project" = "cpu"
  }

  node_taints = [
    "project=cpu:NoSchedule"
  ]

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "memory" {
  name                  = "mempool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size              = var.node_sizes.mem
  enable_auto_scaling  = true
  min_count           = 0
  max_count           = 3
  vnet_subnet_id      = var.vnet_subnet_id

  node_labels = {
    "project" = "mem"
  }

  node_taints = [
    "project=mem:NoSchedule"
  ]

  tags = var.tags
}
