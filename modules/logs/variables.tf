variable "log_analytics_workspace_custom_name" {
  description = "Azure Log Analytics Workspace custom name. Empty by default, using naming convention."
  type        = string
  default     = "analytics-dev"
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
# variable "log_analytics_workspace_custom_name" {
#   description = "Azure Log Analytics Workspace custom name. Empty by default, using naming convention."
#   type        = string
#   default     = "analytics-dev-afolabi"
# }