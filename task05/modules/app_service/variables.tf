variable "name" {
  description = "The name of the Windows Web App"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "location" {
  description = "The location of the Windows Web App"
  type        = string
}

variable "service_plan_id" {
  description = "The ID of the App Service Plan"
  type        = string
}

variable "allowed_ips" {
  description = "List of allowed IP restrictions. Each element is an object with name, ip_address (optional), service_tag (optional), and priority."
  type = list(object({
    name        = string
    ip_address  = optional(string)
    service_tag = optional(string)
    priority    = number
  }))
}

variable "tags" {
  description = "Tags to apply to the Windows Web App"
  type        = map(string)
  default     = {}
}