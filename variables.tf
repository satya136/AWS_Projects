variable "region" {
}
variable "http_port" {
}
variable "ssh_port" {
}
variable "env" {
  default = "dev"
}
variable "instance_type" {
  type = map(any)
}
variable "cidr" {}