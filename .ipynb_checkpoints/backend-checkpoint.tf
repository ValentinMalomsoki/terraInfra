terraform {
  backend "azurerm" {
    resource_group_name  = "val-rg"
    storage_account_name = "mystorevalfo"
    container_name       = "statestore"
    key                  = "terraform.tfstate"
  }
}
