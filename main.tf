# Terraform configuration

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_pet" "petname" {
  length    = 2
  separator = ""
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = var.location
}

module "static_webapp" {
  source                   = "app.terraform.io/shahidazim/static-webapp/azure"
  version                  = "1.0.0"
  resource_group_name      = azurerm_resource_group.example.name
  storage_account_location = var.location
  storage_account_name     = random_pet.petname.id
  source_file              = "www/index.html"
}
