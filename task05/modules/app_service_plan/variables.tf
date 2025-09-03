variable "name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "location" {
  description = "The location of the App Service Plan"
  type        = string
}

variable "os_type" {
  description = "The O/S type for the App Service Plan"
  type        = string
  default     = "Windows"
}

variable "sku_name" {
  description = "The SKU for the plan"
  type        = string
}

variable "worker_count" {
  description = "The number of workers (instances) for the plan"
  type        = number
}

variable "tags" {
  description = "Tags to apply to the App Service Plan"
  type        = map(string)
  default     = {}
}