variable "address_space" {
    type = list(string) 
}
variable "resource_group_name" {
    type  = string
    default = "sai"
  
}
variable "virtual_network_name" {
    type  = string
    default = "saivnet"
  
}
variable "target_region" {
    type = string
    default = "ukwest"
  
}