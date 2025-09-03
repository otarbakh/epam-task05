variable "resource_groups" {
  description = "Map of resource groups to create"
  type = map(object({
    name     = string
    location = string
  }))
}

variable "app_service_plans" {
  description = "Map of app service plans to create"
  type = map(object({
    name           = string
    resource_group = string
    location       = string
    sku_name       = string
    worker_count   = number
  }))
}

variable "app_services" {
  description = "Map of app services to create"
  type = map(object({
    name           = string
    resource_group = string
    location       = string
    service_plan   = string
    allowed_ips = list(object({
      name        = string
      ip_address  = optional(string)
      service_tag = optional(string)
      priority    = number
    }))
  }))
}

variable "traffic_manager" {
  description = "Object for traffic manager"
  type = object({
    profile_name   = string
    resource_group = string
    location       = string
    routing_method = string
    endpoints = map(object({
      target_resource_id = string
    }))
  })
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}