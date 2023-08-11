locals {
    blob_account_name = try(random_string.storage_account_name[0].result, var.storage_account_name) 
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_string" "storage_account_name" {
  count = var.storage_account_name == null ? 1 : 0

  length  = 20
  upper   = false
  special = false
  numeric = false
}

resource "azurerm_storage_account" "storeacc" {
  name                      = local.blob_account_name
  resource_group_name      = azurerm_resource_group.this.name
  location                  = azurerm_resource_group.this.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type

}
resource "azurerm_storage_container" "this" {
  name                  = "${local.blob_account_name}-${var.azurerm_storage_container}"
  storage_account_name  = azurerm_storage_account.storeacc.name
  container_access_type = var.container_access_type
}