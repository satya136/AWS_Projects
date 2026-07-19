variable "region" {}

variable "vpc_cidr" {
  
}

variable "subnet_names" {
  type = list
}

variable "subnet_cidr" {
  type = map
}

variable "sg_names" {}
variable "ports" {}
variable "sg_cidr" {}
variable "sg_to_subnet" {}