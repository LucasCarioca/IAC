resource "azurerm_app_service" "app-service-dev" {
  name                = "${var.name}-dev"
  location            = "centralus"
  resource_group_name = "dev"
  app_service_plan_id = var.app_service_plan_id_dev

  site_config {
    always_on        = true
    linux_fx_version = "DOCKER|${var.image}"
  }

  app_settings = merge(
    var.app_settings_dev,
    {
      "DOCKER_REGISTRY_SERVER_URL"      = var.acr_server
      "DOCKER_REGISTRY_SERVER_PASSWORD" = var.acr_server_username
      "DOCKER_REGISTRY_SERVER_USERNAME" = var.acr_server_password
      "DOCKER_ENABLE_CI"                = "true"
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
    linux_fx_version = "DOCKER|${var.image}"
  }

  app_settings = merge(
    var.app_settings_dev,
    {
      "DOCKER_REGISTRY_SERVER_URL"      = var.acr_server
      "DOCKER_REGISTRY_SERVER_PASSWORD" = var.acr_server_username
      "DOCKER_REGISTRY_SERVER_USERNAME" = var.acr_server_password
      "DOCKER_ENABLE_CI"                = "true"
    }
  )
}