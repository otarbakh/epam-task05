variable "profile_name" {
  description = "The name of the Traffic Manager profile"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "location" {
  description = "The location of the Traffic Manager profile (not used for TM profile but kept for consistency)"
  type        = string
}

variable "routing_method" {
  description = "The routing method of the Traffic Manager profile"
  type        = string
}

variable "endpoints" {
  description = "A map of endpoints to create. The key is the endpoint name, and the value is an object containing target_resource_id."
  type = map(object({
    target_resource_id = string
  }))
}

variable "tags" {
  description = "Tags to apply to the Traffic Manager profile"
  type        = map(string)
  default     = {}
}