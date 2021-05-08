# Configure the Microsoft Azure Provider
provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}

variable "environment" {
    type = string
    default = "dev"
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "rg" {
    name     = "rg-${var.environment}"
    location = "westeurope"

    tags = {
        environment = var.environment
    }
}

resource "azurerm_app_service_plan" "plt_be_plan" {
  name                = "plt-be-plan-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true
  
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "plt_be" {
  name                = "plt-be-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plt_be_plan.id
}

resource "azurerm_storage_account" "plt_fe" {
  name                     = "pltfe${var.environment}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  enable_https_traffic_only = true

  static_website {
    index_document = "index.html"
  }

  tags = {
    environment = var.environment
  }
}