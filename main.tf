terraform {
  backend "azurerm" {
  resource_group_name = "shanvirgdatasources"
  storage_account_name = "shanvirgdatasourcesvnet"
  container_name = "datasources"
  key = "terraform.datasources"
  access_key = "+HoQplMCUMgI9C23RsZv4pDvRHqkm46ry0RZ1gxr82BaDb/qgsRt2NgIQGaqqJXavDsCNtZqFgAF+AStpuhuvw=="
  }
  
}

provider "azurerm" {
    features {
      
    }
    subscription_id = var.subscription_id
    client_id = var.client_id
    tenant_id = var.tenant_id
    client_secret = var.client_secret
  
}

locals {
  setup_name = "practice-hyd"
}

resource "azurerm_resource_group" "rg11" {
  name = "rg11"
  location = "East-US"
  tags =  {
    "name" = "practice-rsg"
  }
  
}
resource "azurerm_app_service_plan" "appplan11" {
  name = "appplan11"
  location = azurerm_resource_group.rg11.location
  resource_group_name = azurerm_resource_group.rg11.name
  sku {
    tier = "Standard"
    size = "S2"
  }
  tags = {
    "name" = "appplan11"
  }
  depends_on = [azurerm_resource_group.rg11]
  
}

resource "azurerm_app_service" "appservice11" {
  name = "appservice11"
  location = azurerm_resource_group.rg11.location
  resource_group_name = azurerm_resource_group.rg11.name
  app_service_plan_id = azurerm_app_service_plan.appplan11.id

  tags = {
    "name" = "appservice11"
  }
  
  depends_on = [azurerm_app_service_plan.appplan11]
}