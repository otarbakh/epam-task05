tags = {
  Creator = "otar_bakhtadze@epam.com"
}

resource_groups = {
  rg1 = {
    name     = "cmaz-wbdw4cma-mod5-rg-01"
    location = "West Europe" # Example, you can change to desired locations
  }
  rg2 = {
    name     = "cmaz-wbdw4cma-mod5-rg-02"
    location = "East US" # Example
  }
  rg3 = {
    name     = "cmaz-wbdw4cma-mod5-rg-03"
    location = "Central US" # Example for Traffic Manager
  }
}

app_service_plans = {
  asp1 = {
    name           = "cmaz-wbdw4cma-mod5-asp-01"
    resource_group = "cmaz-wbdw4cma-mod5-rg-01"
    location       = "West Europe" # Must match the resource group location
    sku_name       = "P0v3"
    worker_count   = 2
  }
  asp2 = {
    name           = "cmaz-wbdw4cma-mod5-asp-02"
    resource_group = "cmaz-wbdw4cma-mod5-rg-02"
    location       = "East US" # Must match the resource group location
    sku_name       = "P1v3"
    worker_count   = 1
  }
}

app_services = {
  app1 = {
    name             = "cmaz-f4p05tns-mod5-app-01"
    resource_group   = "cmaz-f4p05tns-mod5-rg-01"
    location         = "westeurope"
    app_service_plan = "cmaz-f4p05tns-mod5-asp-01"
    ip_restrictions = [
      {
        name       = "allow-ip"
        ip_address = "18.153.146.156/32" # Добавляем /32
        priority   = 100
        action     = "Allow"
      },
      {
        name       = "allow-tm"
        ip_address = "AzureTrafficManager"
        priority   = 200
        action     = "Allow"
      }
    ]
  },
  app2 = {
    name             = "cmaz-f4p05tns-mod5-app-02"
    resource_group   = "cmaz-f4p05tns-mod5-rg-02"
    location         = "eastus"
    app_service_plan = "cmaz-f4p05tns-mod5-asp-02"
    ip_restrictions = [
      {
        name       = "allow-ip"
        ip_address = "18.153.146.156/32" # Добавляем /32
        priority   = 100
        action     = "Allow"
      },
      {
        name       = "allow-tm"
        ip_address = "AzureTrafficManager"
        priority   = 200
        action     = "Allow"
      }
    ]
  }
}

traffic_manager = {
  profile_name   = "cmaz-wbdw4cma-mod5-traf"
  resource_group = "cmaz-wbdw4cma-mod5-rg-03"
  location       = "Central US" # Traffic Manager is global, but we assign a resource group location for the profile (not used in TM profile actually)
  routing_method = "Performance"
  endpoints = {
    app1 = {
      target_resource_id = "" # We will fill this in main.tf with the app service id from module output
    }
    app2 = {
      target_resource_id = "" # Similarly
    }
  }
}