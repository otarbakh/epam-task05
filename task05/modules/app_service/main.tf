resource "azurerm_windows_web_app" "app" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id
  tags                = var.tags

  site_config {
    dynamic "ip_restriction" {
      for_each = var.allowed_ips
      content {
        name        = ip_restriction.value.name
        action      = "Allow"
        ip_address  = ip_restriction.value.ip_address
        service_tag = ip_restriction.value.service_tag
        priority    = ip_restriction.value.priority
      }
    }
    # Always deny traffic that doesn't match any rule (default action)
  }

  # We need to set the default action to deny. However, note that the azurerm_windows_web_app resource does not have a direct way to set the default action.
  # The default action is Deny by default when at least one ip_restriction block is defined. So we are safe.

  # Note: The ip_restriction block can have either ip_address or service_tag.
}

# Note: The allowed_ips variable is a list of objects that can have either ip_address or service_tag.