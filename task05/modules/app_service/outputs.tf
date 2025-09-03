output "id" {
  description = "The ID of the Windows Web App"
  value       = azurerm_windows_web_app.app.id
}

output "default_site_hostname" {
  description = "The default hostname of the Windows Web App"
  value       = azurerm_windows_web_app.app.default_site_hostname
}