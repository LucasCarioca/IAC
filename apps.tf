# Example html app

module "example-html-app" {
  source                   = "./app"
  name                     = "example-html-app-setup"
  app_service_plan_id_dev  = zurerm_app_service_plan.dev-serviceplan.id
  app_service_plan_id_prod = zurerm_app_service_plan.prod-serviceplan.id
  image                    = "htmlex"
  app_settings_dev         = {}
  app_settings_prod        = {}
}