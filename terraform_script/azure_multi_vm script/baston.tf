resource "azurerm_bastion_host" "saibaston" {
  
  name                = "examplebastion"
  location            = azurerm_resource_group.sairg2.location
  resource_group_name = azurerm_resource_group.sairg2.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.saibastion.id
    public_ip_address_id = azurerm_public_ip.saiqt[0].id

  }
}
