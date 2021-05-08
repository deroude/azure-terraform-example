# Configure the Microsoft Azure Provider
provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}

variable "environment" {
    type = object({
        tag = string
    })
    default = {
        tag = "dev"
    }
}

variable "resource_group" {
  type = object({
    name    = string
    location = string
  })
  description = "The resource group to be deployed"
  default = {
      name = "rg-dev"
      location = "West Europe"
  }
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "rg" {
    name     = var.resource_group.name
    location = var.resource_group.location

    tags = {
        environment = var.environment.tag
    }
}

resource "azurerm_app_service_plan" "plt_be_plan" {
  name                = "plt-be-plan-${var.environment.tag}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "plt_be" {
  name                = "plt-be-${var.environment.tag}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plt_be_plan.id
}

resource "azurerm_storage_account" "plt_fe" {
  name                     = "pltfe${var.environment.tag}"
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
    environment = var.environment.tag
  }
}