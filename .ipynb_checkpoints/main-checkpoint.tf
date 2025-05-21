terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.2.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.29.0"
    }
  }
}

module "my_net" {
    source = "./Vnet"
}


provider "azurerm" {
  features {}
  subscription_id = "537bb5af-974a-40ed-9493-5761b69e345a"
}