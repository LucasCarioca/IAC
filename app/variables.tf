variable "name" {}
variable "app_service_plan_id_dev" {}
variable "app_service_plan_id_prod" {}
variable "image" {}
variable "app_settings_dev" {}
variable "app_settings_prod" {}

# Example app settings
# {
#     "DOCKER_REGISTRY_SERVER_URL" = var.acr_server
#     "DOCKER_REGISTRY_SERVER_PASSWORD" = var.acr_password
#     "DOCKER_REGISTRY_SERVER_USERNAME" = var.acr_username
#     "DOCKER_ENABLE_CI" = "true"
# }