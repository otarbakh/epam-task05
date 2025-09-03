# Create resource groups
module "resource_groups" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location
  tags     = var.tags
}

# Create app service plans
module "app_service_plans" {
  source   = "./modules/app_service_plan"
  for_each = var.app_service_plans

  name                = each.value.name
  resource_group_name = each.value.resource_group
  location            = each.value.location
  sku_name            = each.value.sku_name
  worker_count        = each.value.worker_count
  os_type             = "Windows"
  tags                = var.tags

  depends_on = [module.resource_groups]
}

# Create app services
module "app_services" {
  source   = "./modules/app_service"
  for_each = var.app_services

  name                = each.value.name
  resource_group_name = each.value.resource_group
  location            = each.value.location
  service_plan_id     = module.app_service_plans[each.value.service_plan].id # We are using the key of the app service plan in the map to reference the module instance
  allowed_ips         = each.value.allowed_ips
  tags                = var.tags

  depends_on = [module.app_service_plans]
}

# Create traffic manager profile and endpoints
module "traffic_manager" {
  source = "./modules/traffic_manager"

  profile_name        = var.traffic_manager.profile_name
  resource_group_name = var.traffic_manager.resource_group
  location            = var.traffic_manager.location
  routing_method      = var.traffic_manager.routing_method
  endpoints = {
    app1 = {
      target_resource_id = module.app_services["app1"].id
    }
    app2 = {
      target_resource_id = module.app_services["app2"].id
    }
  }
  tags = var.tags

  depends_on = [module.app_services]
}