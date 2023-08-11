variable "resource_group_name" {
    type        = string
    description = "The name of RG"
    default     = "afolabi-blob-storgage-rg"
}

variable "prefix" {
  type        = string
  description = "Prefix of the resource name"
  default     = "afolabi-blob-storage"  
}

variable "location" {
  type        = string
  default     = "WestEurope"
  description = "Resource group location"
}

variable "storage_account_name" {
  type        = string
  default     = null
  description = "Azure Blob Storage account name"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "account_tier" {
  description   = "The Storage Account Tier"
  type          = string
  default       = "Standard"
}

variable "account_kind" {
  description   = "The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  default       = "StorageV2"
  type          = string
}
variable "azurerm_storage_container" {
  description   = "The name of the Blob container"
  type          = string
  default       = "dev-container"
}
variable "container_access_type" {
  description   = "The access type for Blob Storage"
  type          = string
  default       = "private"
}

variable "account_replication_type" {
  description = "The account_replication_type"
  type = string
  default = "LRS"
}