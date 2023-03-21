resource "azurerm_linux_virtual_machine" "saivm" {
  count                 = length(var.machine_name.name)
  resource_group_name   = var.resource_group_name.name
  location              = var.resource_group_name.location
  name                  = var.machine_name.name[count.index]
  size                  = "Standard_B1s"
  admin_username        = "satya"
  admin_password        = "satya@1234"
  network_interface_ids = [azurerm_network_interface.sainic[count.index].id]


  disable_password_authentication = false
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

}

resource "null_resource" "cluster" {
  count = terraform.workspace == "dev" ? length(var.machine_name.name) : 0
  triggers = {
    version = var.triggers
  }
  provisioner "remote-exec" {

    inline = [
      "sudo apt update",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sh get-docker.sh",
      "sudo usermod -aG docker satya",
      "sudo apt update"
    ]

    connection {
      host     = azurerm_public_ip.saiip[count.index].ip_address
      user     = "satya"
      password = "satya@1234"

    }
  }

  depends_on = [
    azurerm_network_interface.sainic
  ]
}
resource "null_resource" "cluster1" {
  count = terraform.workspace == "qt" ? length(var.machine_name.name) : 0
  triggers = {
    version = var.triggers
  }
  provisioner "remote-exec" {

    inline = [
      "sudo apt update",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sh get-docker.sh",
      "sudo usermod -aG docker satya",
      "sudo apt update"
    ]

    connection {
      host     = azurerm_public_ip.saiip[count.index].ip_address
      user     = "satya"
      password = "satya@1234"

    }
  }

  depends_on = [
    azurerm_network_interface.sainic
  ]
}