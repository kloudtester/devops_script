resource "azurerm_linux_virtual_machine" "sahithivm" {
  count = length(var.machine_name.name)

  name                  = var.machine_name.name[count.index]
  resource_group_name   = var.resource_group_name.name
  location              = var.resource_group_name.location
  size                  = "Standard_B1s"
  admin_username        = "satya"
  network_interface_ids = var.env == "dev" ? [azurerm_network_interface.sainic[count.index].id] : [azurerm_network_interface.sainic1[count.index].id]
  tags = {
    Env = var.env
  }
  admin_ssh_key {
    username   = "satya"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "null_resource" "qtnull" {
  count = var.env == "dev" ? length(var.machine_name.name) : 0
  triggers = {
    triggers = var.triggers
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update && sudo apt install apache2 wget -y",
      "sudo apt install wget -y",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sh get-docker.sh",
      "sudo usermod -aG docker satya",
      "sudo apt update"
    ]
    connection {
      type        = "ssh"
      user        = "satya"
      private_key = file("~/.ssh/id_rsa")
      host        = azurerm_public_ip.saidev[count.index].ip_address
    }
  }
}
