# create vnet it is depends on resource group
resource "azurerm_virtual_network" "saivnet" {
  name                = var.vnet.name
  location            = var.resource_group_name.location
  resource_group_name = var.resource_group_name.name
  address_space       = var.vnet.address_space
  depends_on = [
    azurerm_resource_group.sairg2
  ]
}
# create subnet dependes on vnet 
resource "azurerm_subnet" "saisubnet" {
  count                = length(var.subnet.name)
  name                 = var.subnet.name[count.index]
  virtual_network_name = var.vnet.name
  resource_group_name  = var.resource_group_name.name
  address_prefixes     = [cidrsubnet(var.vnet.address_space[0], 8, count.index)]
  depends_on = [
    azurerm_virtual_network.saivnet
  ]
}
resource "azurerm_subnet" "saibastion" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = var.vnet.name
  resource_group_name  = var.resource_group_name.name
  address_prefixes     = ["192.0.4.0/24"]
  depends_on = [
    azurerm_virtual_network.saivnet
  ]
}
resource "azurerm_public_ip" "saidev" {
  count               = var.env == "dev" ? length(var.machine_name.name) : 0
  name                = "webpublic1-${count.index}"
  location            = var.resource_group_name.location
  resource_group_name = var.resource_group_name.name
  allocation_method   = "Dynamic"

  depends_on = [
    azurerm_subnet.saisubnet
  ]
}

resource "azurerm_network_interface" "sainic" {
  count               = var.env == "dev" ? length(var.machine_name.name) : 0
  name                = "webnic-${count.index}"
  location            = var.resource_group_name.location
  resource_group_name = var.resource_group_name.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.saisubnet[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.saidev[count.index].id
  }

  depends_on = [
    azurerm_subnet.saisubnet

  ]
}
resource "azurerm_public_ip" "saiqt" {
  count               = var.env == "qt" ? length(var.machine_name.name) : 0
  name                = "webpublic-${count.index}"
  location            = var.resource_group_name.location
  resource_group_name = var.resource_group_name.name
  allocation_method   = "Dynamic"

  depends_on = [
    azurerm_subnet.saisubnet
  ]
}
resource "azurerm_network_interface" "sainic1" {
  count               = var.env == "qt" ? length(var.machine_name.name) : 0
  name                = "webnic1-${count.index}"
  location            = var.resource_group_name.location
  resource_group_name = var.resource_group_name.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.saisubnet[count.index].id
    private_ip_address_allocation = "Dynamic"

  }

  depends_on = [
    azurerm_subnet.saisubnet

  ]
}
resource "azurerm_network_security_group" "sainsg" {
  name                = "webnsg"
  location            = var.resource_group_name.location
  resource_group_name = var.resource_group_name.name

  security_rule {
    name                       = "openssh"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "openhttp"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"


  }

  tags = {
    Env = var.env
  }

  depends_on = [
    azurerm_resource_group.sairg2
  ]
}

resource "azurerm_network_interface_security_group_association" "satya_nisg" {
  count                     = length(var.machine_name.name)
  network_interface_id      = var.env == "dev" ? azurerm_network_interface.sainic[count.index].id : azurerm_network_interface.sainic1[count.index].id
  network_security_group_id = azurerm_network_security_group.sainsg.id

  depends_on = [
    azurerm_network_security_group.sainsg,
    azurerm_network_interface.sainic,
    azurerm_network_interface.sainic1
  ]

}