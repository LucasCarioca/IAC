resource "azurerm_app_service" "app-service-dev" {
  name                = "${var.name}-dev"
  location            = "centralus"
  resource_group_name = "dev"
  app_service_plan_id = var.app_service_plan_id_dev

  site_config {
    always_on        = true
  }

  app_settings = merge(
    var.app_settings_dev,
    {
    }
  )
}

resource "azurerm_app_service" "app-service-prod" {
  name                = var.name
  location            = "centralus"
  resource_group_name = "prod"
  app_service_plan_id = var.app_service_plan_id_prod

  site_config {
    always_on        = true
  }

  app_settings = merge(
    var.app_settings_dev,
    {
    }
  )
}