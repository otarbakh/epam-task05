output "id" {
  description = "The ID of the Resource Group"
  value       = azurerm_resource_group.rg.id
}

output "location" {
  description = "The location of the Resource Group"
  value       = azurerm_resource_group.rg.location
}