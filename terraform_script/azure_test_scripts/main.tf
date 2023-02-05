resource "azurerm_resource_group" "example" {
  name     = "var.resource_group_name"
  location = "var.target_region"
}
resource "azurerm_virtual_network" "example" {
  name                = "var.virtual_network_name"
  resource_group_name = "var.resource_group_name"
  location            = "var.target_region"
  address_space       = ["var.address_space"]
}
