resource "azurerm_windows_web_app" "app" {
  name                = var.name
  resource_group_name = var.resource_group
  location            = var.location
  service_plan_id     = var.app_service_plan_id

  site_config {
    always_on = false


    scm_use_main_ip_restriction = true


    ip_restriction_default_action = "Deny"


    dynamic "ip_restriction" {
      for_each = var.ip_restrictions
      content {
        name     = ip_restriction.value.name
        priority = ip_restriction.value.priority
        action   = ip_restriction.value.action


        ip_address = ip_restriction.value.ip_address != "AzureTrafficManager" ? ip_restriction.value.ip_address : null


        service_tag = ip_restriction.value.ip_address == "AzureTrafficManager" ? "AzureTrafficManager" : null
      }
    }
  }

  tags = var.tags
}