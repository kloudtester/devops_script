provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "sairg" {
  name     = "sairg"
  location = "West Europe"
}