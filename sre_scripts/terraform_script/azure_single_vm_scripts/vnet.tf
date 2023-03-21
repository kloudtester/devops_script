resource "azurerm_virtual_network" "saivnet" {
  name                = "saivnet"
  location            = azurerm_resource_group.sairg.location
  resource_group_name = azurerm_resource_group.sairg.name
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "saisubnet" {
  name                 = "saisubnet"
  virtual_network_name = azurerm_virtual_network.saivnet.name
  resource_group_name  = azurerm_resource_group.sairg.name
  address_prefixes     = [ "10.0.0.0/24" ]
  depends_on = [
    azurerm_virtual_network.saivnet
  ]
}
resource "azurerm_public_ip" "saidev" {
  name                = "webpublic"
  location            = azurerm_resource_group.sairg.location
  resource_group_name = azurerm_resource_group.sairg.name
  allocation_method   = "Dynamic"

  depends_on = [
    azurerm_subnet.saisubnet
  ]
}
resource "azurerm_network_interface" "sainic" {
  name                = "sai-nic"
  location            = azurerm_resource_group.sairg.location
  resource_group_name = azurerm_resource_group.sairg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.saisubnet.id
    private_ip_address_allocation = "Dynamic"
     public_ip_address_id         = azurerm_public_ip.saidev.id
  }
}
