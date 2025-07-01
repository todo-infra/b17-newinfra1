terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "4972e01e-b3c0-45e3-becf-c21112caced1"
}