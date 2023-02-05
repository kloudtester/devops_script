variable "vpc_details" {
  type = object({
    name      = string
    vpc_range = string
  })

}

