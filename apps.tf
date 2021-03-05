# Example html app
variable "mongodb_url_dev" {}
variable "mongodb_url_prod" {}

resource "random_string" "secret-dev" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

resource "random_string" "secret-prod" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

module "oscars-api" {
  source                   = "./app-container"
  name                     = "oscars-api"
  app_service_plan_id_dev  = azurerm_app_service_plan.dev-serviceplan.id
  app_service_plan_id_prod = azurerm_app_service_plan.prod-serviceplan.id
  image                    = "desouza.azurecr.io/oscars-api"
  app_settings_dev = {
    "MONGODB_URL" : var.mongodb_url_dev
    "JWT_SECRET" : random_string.secret-dev.result
  }
  app_settings_prod = {
    "MONGODB_URL" : var.mongodb_url_prod
    "JWT_SECRET" : random_string.secret-prod.result
  }

  acr_server   = "https://${data.azurerm_container_registry.common-acr.login_server}"
  acr_username = data.azurerm_container_registry.common-acr.admin_username
  acr_password = data.azurerm_container_registry.common-acr.admin_password
}

module "oscars-ui" {
  source                   = "./app-container"
  name                     = "oscars-ui"
  app_service_plan_id_dev  = azurerm_app_service_plan.dev-serviceplan.id
  app_service_plan_id_prod = azurerm_app_service_plan.prod-serviceplan.id
  image                    = "desouza.azurecr.io/oscars-ui"
  app_settings_dev         = {}
  app_settings_prod        = {}

  acr_server   = "https://${data.azurerm_container_registry.common-acr.login_server}"
  acr_username = data.azurerm_container_registry.common-acr.admin_username
  acr_password = data.azurerm_container_registry.common-acr.admin_password
}