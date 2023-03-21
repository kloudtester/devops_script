resource_group_name = {
  location = "eastus"
  name     = "sairg"
}
vnet = {
  address_space = ["192.0.0.0/16"]
  name          = "sahithivnet1"
}
subnet = {
  name = ["web", "app"]
}
triggers = "4"
env      = "qt"
machine_name = {
  name = ["vm3", "vm4"]
}