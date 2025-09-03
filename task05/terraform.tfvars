# ---------------------------
# Resource Groups
# ---------------------------
resource_groups = {
  rg1 = {
    name     = "cmaz-wbdw4cma-mod5-rg-01" # Resource Group 1
    location = "westeurope"               # Location: West Europe
  },
  rg2 = {
    name     = "cmaz-wbdw4cma-mod5-rg-02" # Resource Group 2
    location = "eastus"                   # Location: East US
  },
  rg3 = {
    name     = "cmaz-wbdw4cma-mod5-rg-03" # Resource Group 3
    location = "centralus"                # Location: Central US
  }
}

# ---------------------------
# App Service Plans
# ---------------------------
app_service_plans = {
  asp1 = {
    name           = "cmaz-wbdw4cma-mod5-asp-01" # App Service Plan 1
    resource_group = "cmaz-wbdw4cma-mod5-rg-01"  # Belongs to RG1
    location       = "westeurope"                # Same location as RG1
    worker_count   = 2                           # Worker instances = 2
    sku            = "P0v3"                      # SKU pricing tier
  },
  asp2 = {
    name           = "cmaz-wbdw4cma-mod5-asp-02" # App Service Plan 2
    resource_group = "cmaz-wbdw4cma-mod5-rg-02"  # Belongs to RG2
    location       = "eastus"                    # Same location as RG2
    worker_count   = 1                           # Worker instances = 1
    sku            = "P1v3"                      # SKU pricing tier
  }
}

# ---------------------------
# App Services
# ---------------------------
app_services = {
  app1 = {
    name             = "cmaz-wbdw4cma-mod5-app-01" # App Service 1
    resource_group   = "cmaz-wbdw4cma-mod5-rg-01"  # Belongs to RG1
    location         = "westeurope"
    app_service_plan = "cmaz-wbdw4cma-mod5-asp-01" # Runs on ASP1
    ip_restrictions = [
      {
        name       = "allow-ip"          # Rule: Allow specific IP
        ip_address = "18.153.146.156/32" # Verification Agent IP
        priority   = 100
        action     = "Allow"
      },
      {
        name       = "allow-tm" # Rule: Allow Traffic Manager
        ip_address = "AzureTrafficManager"
        priority   = 200
        action     = "Allow"
      }
    ]
  },
  app2 = {
    name             = "cmaz-wbdw4cma-mod5-app-02" # App Service 2
    resource_group   = "cmaz-wbdw4cma-mod5-rg-02"  # Belongs to RG2
    location         = "eastus"
    app_service_plan = "cmaz-wbdw4cma-mod5-asp-02" # Runs on ASP2
    ip_restrictions = [
      {
        name       = "allow-ip" # Rule: Allow specific IP
        ip_address = "18.153.146.156/32"
        priority   = 100
        action     = "Allow"
      },
      {
        name       = "allow-tm" # Rule: Allow Traffic Manager
        ip_address = "AzureTrafficManager"
        priority   = 200
        action     = "Allow"
      }
    ]
  }
}

# ---------------------------
# Traffic Manager
# ---------------------------
traffic_manager = {
  name           = "cmaz-wbdw4cma-mod5-traf"  # TM profile name
  resource_group = "cmaz-wbdw4cma-mod5-rg-03" # Belongs to RG3
  location       = "centralus"                # Same as RG3
  routing_method = "Performance"              # Performance-based routing
  endpoints = {
    app1 = {
      target_resource_id = "" # Will be filled from module
    },
    app2 = {
      target_resource_id = ""
    }
  }
}

# ---------------------------
# Tags
# ---------------------------
tags = {
  Creator = "otar_bakhtadze@epam.com" # Updated Creator tag
}
