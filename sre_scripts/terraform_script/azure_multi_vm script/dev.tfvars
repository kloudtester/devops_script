resource_group_name = {
  location = "centralindia"
  name     = "sahithirg1"
}
vnet = {
  address_space = ["10.0.0.0/16"]
  name          = "sahithivnet"
}
subnet = {
  name = ["web", "app"]
}
machine_name = {
  name = ["vm1", "vm2"]

}
triggers = "4"
env      = "dev"