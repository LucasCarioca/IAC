terraform {
  backend "azurerm" {
    storage_account_name = "desouza"
    container_name       = "terraform-state"
    key                  = "primary-infra.tfstate"
    resource_group_name  = "common"
  }
}