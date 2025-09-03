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
    name           = "cmaz-wbdw4cma-mod5-app-01"
    resource_group = "cmaz-wbdw4cma-mod5-rg-01"
    location       = "West Europe"               # Must match the resource group location
    service_plan   = "cmaz-wbdw4cma-mod5-asp-01" # This is the name, but we will use the ID in the module. We'll have to adjust in main.tf.
    allowed_ips = [
      {
        name       = "allow-ip"
        ip_address = "18.153.146.156"
        priority   = 100
      },
      {
        name        = "allow-tm"
        service_tag = "AzureTrafficManager"
        priority    = 200
      }
    ]
  }
  app2 = {
    name           = "cmaz-wbdw4cma-mod5-app-02"
    resource_group = "cmaz-wbdw4cma-mod5-rg-02"
    location       = "East US"                   # Must match the resource group location
    service_plan   = "cmaz-wbdw4cma-mod5-asp-02" # This is the name, but we will use the ID in the module.
    allowed_ips = [
      {
        name       = "allow-ip"
        ip_address = "18.153.146.156"
        priority   = 100
      },
      {
        name        = "allow-tm"
        service_tag = "AzureTrafficManager"
        priority    = 200
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