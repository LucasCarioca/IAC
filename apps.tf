# Example html app

module "example-html-app" {
  source                   = "./app"
  name                     = "example-html-app-setup"
  app_service_plan_id_dev  = azurerm_app_service_plan.dev-serviceplan.id
  app_service_plan_id_prod = azurerm_app_service_plan.prod-serviceplan.id
  image                    = "desouza.azurecr.io/htmlex:latest"
  app_settings_dev         = {}
  app_settings_prod        = {}

  acr_server          = var.acr_server
  acr_server_username = var.acr_server_username
  acr_server_password = var.acr_server_password
}