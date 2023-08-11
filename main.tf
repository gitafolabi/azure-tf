locals {
  allowed_cidrs = ["10.0.0.0/24", "10.0.1.0/24"]
}

data "azurerm_client_config" "current" {
}

module "blob" {
  source = "../dev/modules/blob"
  resource_group_name = var.resource_group_name
  location = var.location
}

module "cosmosdb" {
  source = "../dev/modules//cosmosdb"

  location = "WestEurope"
  cosmosdb_account_location = var.location
  
}

module "azure_virtual_network" {
  source  = "../dev/modules/azure_virtual_network"

  environment    = var.environment
  location       = var.location
  location_short = var.location
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name = var.resource_group_name

  vnet_cidr = ["10.0.0.0/19"]
}

module "node_network_subnet" {
  source  = "../dev/modules/node_network_subnet"

  environment    = var.environment
  location_short = var.location
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name  = var.resource_group_name
  virtual_network_name = module.azure_virtual_network.virtual_network_name

  name_suffix = "nodes"

  subnet_cidr_list = ["10.0.0.0/20"]

  service_endpoints = ["Microsoft.Storage"]
}

module "appgw_network_subnet" {
  source  = "../dev/modules/appgw_network_subnet"

  environment    = var.environment
  location_short = var.location
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name  = var.resource_group_name
  virtual_network_name = module.azure_virtual_network.virtual_network_name

  name_suffix = "appgw"

  subnet_cidr_list = ["10.0.20.0/24"]
}


module "log" {
  source = "../dev/modules/logs"

  tags  = var.tags
}



resource "tls_private_key" "key" {
  algorithm = "RSA"
}

module "aks" {
  source  = "../dev/modules/aks"

  providers = {
    kubernetes = kubernetes.aks-module
    helm       = helm.aks-module
  }

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  resource_group_name = var.resource_group_name
  location            = var.location
  location_short      = var.location

  private_cluster_enabled = false
  service_cidr            = "10.0.16.0/22"
  kubernetes_version      = "1.24"

  vnet_id         = module.azure_virtual_network.virtual_network_id
  nodes_subnet_id = module.node_network_subnet.subnet_id
  nodes_pools = [
    {
      name            = "pool1"
      count           = 1
      vm_size         = "Standard_D2_v3"
      os_type         = "Linux"
      os_disk_type    = "Ephemeral"
      os_disk_size_gb = 30
      vnet_subnet_id  = module.node_network_subnet.subnet_id
    },
    {
      name                = "bigpool1"
      count               = 3
      vm_size             = "Standard_F8s_v2"
      os_type             = "Linux"
      os_disk_size_gb     = 30
      vnet_subnet_id      = module.node_network_subnet.subnet_id
      enable_auto_scaling = true
      min_count           = 3
      max_count           = 9
    }
  ]

  linux_profile = {
    username = "nodeadmin"
    ssh_key  = tls_private_key.key.public_key_openssh
  }

  azure_policy_enabled           = false

  logs_destinations_ids = [module.log.log_analytics_workspace_id]

  appgw_subnet_id = module.appgw_network_subnet.subnet_id

  appgw_ingress_controller_values = { "verbosityLevel" = 5, "appgw.shared" = true }
  cert_manager_settings           = { "cainjector.nodeSelector.agentpool" = "default", "nodeSelector.agentpool" = "default", "webhook.nodeSelector.agentpool" = "default" }

  container_registries_id = module.acr.acr_id

  key_vault_secrets_provider = {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }
}

module "acr" {
  source  = "../dev/modules/acr"

  location            = var.location
  location_short      = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  logs_destinations_ids = [module.log.log_analytics_workspace_id]
}