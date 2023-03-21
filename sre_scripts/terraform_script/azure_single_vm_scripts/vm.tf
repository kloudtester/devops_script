resource "azurerm_linux_virtual_machine" "saivm" {

  name                  = "saivm"
  resource_group_name   = azurerm_resource_group.sairg.name
  location              = azurerm_resource_group.sairg.location
  size                  = "Standard_B1s"
  admin_username        = "satya"
  network_interface_ids = [ azurerm_network_interface.sainic.id ]
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
  triggers = {
    triggers = 8
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install openjdk-11-jdk -y",
      "java -version",
      "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg",
      "sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt update",
      "sudo apt install jenkins -y",
      "sudo systemctl start jenkins.service"
    ]
    connection {
      type        = "ssh"
      user        = "satya"
      private_key = file("~/.ssh/id_rsa")
      host        = azurerm_public_ip.saidev.ip_address
    }
  }
}
