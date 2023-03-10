resource "azurerm_virtual_network" "saivnet" {
  name                = var.vnet.name
  location            = var.resource_group_name.location
  resource_group_name = var.resource_group_name.name
  address_space       = var.vnet.address_space
  depends_on = [
    azurerm_resource_group.sairg
  ]
}

resource "azurerm_subnet" "saisubnet" {
  count                = length(var.subnet.name)
  name                 = var.subnet.name[count.index]
  virtual_network_name = var.vnet.name
  resource_group_name  = var.resource_group_name.name
  address_prefixes     = [cidrsubnet(var.vnet.address_space[0], 8, count.index)]
  depends_on = [
    azurerm_resource_group.sairg,
    azurerm_virtual_network.saivnet
  ]
}
resource "azurerm_network_security_group" "sainsg" {
  name                = "myngs"
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
    Env = terraform.workspace
  }

  depends_on = [
    azurerm_resource_group.sairg
  ]
}


resource "azurerm_public_ip" "saiip" {
  count = length(var.machine_name.name) 
  name                = "webpublic${count.index}"
  location            = var.resource_group_name.location
  resource_group_name = var.resource_group_name.name
  allocation_method   = "Dynamic"

  depends_on = [
    azurerm_resource_group.sairg
  ]
}

resource "azurerm_network_interface" "sainic" {
  count = var.env == "dev" ? length(var.machine_name.name) : 0

  name                = "sainic"
  location            = var.resource_group_name.location
  resource_group_name = var.resource_group_name.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.saisubnet[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.saiip[count.index].id
  }
}
resource "azurerm_network_interface" "sainic1" {
  count = var.env == "qa" ? length(var.machine_name.name) : 0

  name                = "sainic2"
  location            = var.resource_group_name.location
  resource_group_name = var.resource_group_name.name

  ip_configuration {
    name                          = "internal1"
    subnet_id                     = azurerm_subnet.saisubnet[1].id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_subnet.saisubnet,
    azurerm_public_ip.saiip
  ]
}




resource "azurerm_network_interface_security_group_association" "sainic_nsg_assc1" {
  count = length(var.machine_name.name)
   network_interface_id      = var.env == "dev" ? azurerm_network_interface.sainic[count.index].id : azurerm_network_interface.sainic1[count.index].id
  network_security_group_id = azurerm_network_security_group.sainsg.id
}