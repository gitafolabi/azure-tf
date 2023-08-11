
variable "azure_region" {
  description = "Azure region to use."
  type        = string
  default = "WestEurope"
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
  default = "afolabi"
}

variable "environment" {
  description = "Project environment"
  type        = string
  default = "dev"
}

variable "stack" {
  description = "Project stack name"
  type        = string
  default = "infra"
}

variable "location" {
  type = string
  default = "WestEurope"
}

variable "resource_group_name" {
  description = "Specifies the resource group name"
  default     = "afolabi_sla_resource_group"
  type        = string
}

variable "tags" {
  description = "(Optional) Specifies tags for all the resources"
  default     = {
    createdWith = "Terraform"
  }
}


########Log Analytics#######
variable "log_analytics_workspace_sku" {
  description = "Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, and PerGB2018 (new Sku as of 2018-04-03)."
  type        = string
  default     = "PerGB2018"
}

variable "log_analytics_workspace_retention_in_days" {
  description = "The workspace data retention in days. Possible values range between 30 and 730."
  type        = number
  default     = 30
}

variable "logs_storage_account_enabled" {
  description = "Whether the dedicated Storage Account for logs is created."
  type        = bool
  default     = true
}

variable "logs_storage_account_kind" {
  description = "Storage Account Kind"
  type        = string
  default     = "StorageV2"
}

variable "logs_storage_account_tier" {
  description = "Storage Account tier"
  type        = string
  default     = "Standard"
}

variable "logs_storage_account_replication_type" {
  description = "Storage Account Replication type"
  type        = string
  default     = "LRS"
}

variable "logs_storage_min_tls_version" {
  description = "Storage Account minimal TLS version"
  type        = string
  default     = "TLS1_2"
}

variable "logs_storage_account_enable_advanced_threat_protection" {
  description = "Enable/disable Advanced Threat Protection, see [here](https://docs.microsoft.com/en-us/azure/storage/common/storage-advanced-threat-protection?tabs=azure-portal) for more information."
  type        = bool
  default     = false
}

variable "logs_storage_account_enable_https_traffic_only" {
  description = "Enable/disable HTTPS traffic only"
  type        = bool
  default     = true
}

variable "logs_storage_account_enable_archived_logs_fileshare" {
  description = "Enable/disable archived-logs file share creation"
  type        = bool
  default     = false
}

variable "logs_storage_account_archived_logs_fileshare_quota" {
  description = "The maximum size in GB of the archived-logs file share, default is 5120"
  type        = number
  default     = null
}

variable "logs_storage_account_enable_archiving" {
  description = "Enable/disable blob archiving lifecycle"
  type        = bool
  default     = true
}

variable "tier_to_cool_after_days_since_modification_greater_than" {
  description = "Change blob tier to cool after x days without modification"
  type        = number
  default     = 30
}

variable "tier_to_archive_after_days_since_modification_greater_than" {
  description = "Change blob tier to Archive after x days without modification"
  type        = number
  default     = 90
}

variable "delete_after_days_since_modification_greater_than" {
  description = "Delete blob after x days without modification"
  type        = number
  default     = 365
}

variable "log_analytics_workspace_extra_tags" {
  description = "Extra tags to add to the Log Analytics Workspace"
  type        = map(string)
  default     = {}
}

variable "log_analytics_workspace_custom_name" {
  description = "Azure Log Analytics Workspace custom name. Empty by default, using naming convention."
  type        = string
  default     = "analytics-dev"
}