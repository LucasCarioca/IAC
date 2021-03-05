variable "tenant_id" {}
variable "subscription_id" {}
variable "acr_server" {}
variable "acr_server_username" {}
variable "acr_server_password" {}

variable "resource_group_dev" {
  default = "dev"
}

variable "resource_group_prod" {
  default = "prod"
}

variable "resource_group_common" {
  default = "common"
}

provider "azurerm" {
  version = ">= 2.0"
  features {}
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

data "azurerm_resource_group" "dev-rg" {
  name = var.resource_group_dev
}

data "azurerm_resource_group" "prod-rg" {
  name = var.resource_group_prod
}

data "azurerm_container_registry" "common-acr" {
  name                = "desouza"
  resource_group_name = var.resource_group_common
}

resource "azurerm_app_service_plan" "dev-serviceplan" {
  name                = "dev-appserviceplan"
  location            = data.azurerm_resource_group.dev-rg.location
  resource_group_name = data.azurerm_resource_group.dev-rg.name

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service_plan" "prod-serviceplan" {
  name                = "prod-appserviceplan"
  location            = data.azurerm_resource_group.prod-rg.location
  resource_group_name = data.azurerm_resource_group.prod-rg.name

  sku {
    tier = "Basic"
    size = "B1"
  }
}