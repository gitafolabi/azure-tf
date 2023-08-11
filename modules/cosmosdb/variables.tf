variable "resource_group_name" {
    type        = string
    description = "The name of RG"
    default     = "afolabi-cosmos-rg"
}

variable "prefix" {
  type        = string
  description = "Prefix of the resource name"
  default     = "afolabi-cosmos-db"  
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Resource group location"
}

variable "cosmosdb_account_name" {
  type        = string
  default     = null
  description = "Cosmos db account name"
}

variable "cosmosdb_account_location" {
  type        = string
  default     = "eastus"
  description = "Cosmos db account location"
}

variable "cosmosdb_sqldb_name" {
  type        = string
  default     = "afolabi-default-cosmosdb-sqldb"
  description = "value"
}

variable "sql_container_name" {
  type        = string
  default     = "afolabi-default-sql-container"
  description = "SQL API container name."
}

variable "max_throughput" {
  type        = number
  default     = 4000
  description = "Cosmos db database max throughput"
  validation {
    condition     = var.max_throughput >= 4000 && var.max_throughput <= 1000000
    error_message = "Cosmos db autoscale max throughput should be equal to or greater than 4000 and less than or equal to 1000000."
  }
  validation {
    condition     = var.max_throughput % 100 == 0
    error_message = "Cosmos db max throughput should be in increments of 100."
  }
}

variable "offer_type" {
  description = "CosmoDB offr type"
  type = string
  default = "Standard"
}

variable "kind" {
  description = "CosmodDB kind"
  type = string
  default = "GlobalDocumentDB"
}