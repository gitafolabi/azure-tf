resource "azurerm_role_assignment" "aks_acr_pull_allowed" {

  principal_id         = azurerm_user_assigned_identity.aks_user_assigned_identity.principal_id
  scope                = var.container_registries_id
  role_definition_name = "AcrPull"
}
