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
  source                   = "./app-linux"
  name                     = "oscars-api"
  app_service_plan_id_dev  = azurerm_app_service_plan.dev-serviceplan.id
  app_service_plan_id_prod = azurerm_app_service_plan.prod-serviceplan.id
  app_settings_dev = {
    "MONGODB_URL" : var.mongodb_url_dev
    "JWT_SECRET" : random_string.secret-dev.result
  }
  app_settings_prod = {
    "MONGODB_URL" : var.mongodb_url_prod
    "JWT_SECRET" : random_string.secret-prod.result
  }
  cors_dev  = ["https://oscars-ui-dev.azurewebsites.net"]
  cors_prod = ["https://oscars-ui.azurewebsites.net"]
}

module "oscars-ui" {
  source                   = "./app-linux"
  name                     = "oscars-ui"
  app_service_plan_id_dev  = azurerm_app_service_plan.dev-serviceplan.id
  app_service_plan_id_prod = azurerm_app_service_plan.prod-serviceplan.id
  app_settings_dev         = {}
  app_settings_prod        = {}
  cors_dev                 = []
  cors_prod                = []
}