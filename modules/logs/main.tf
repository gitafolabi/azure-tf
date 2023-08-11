# Log Analytics
resource "azurerm_log_analytics_workspace" "log_workspace" {
  name = var.log_analytics_workspace_custom_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = var.log_analytics_workspace_sku
  retention_in_days = var.log_analytics_workspace_retention_in_days

  tags = var.tags
}

resource "azurerm_log_analytics_solution" "log_workspace" {
  location              = var.location
  resource_group_name   = var.resource_group_name
  solution_name         = "ContainerInsights"
  workspace_name        = azurerm_log_analytics_workspace.log_workspace.name
  workspace_resource_id = azurerm_log_analytics_workspace.log_workspace.id

  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }
}

