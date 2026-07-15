variable "region" {
  default = "us-east-1"
}
variable "tgnames" {
  default = {Red = "/red/index.html",Blue = "/blue/index.html"}
}
variable "tgport" {
  default = 80
}
variable "tgprotocol" {
  default = "HTTP"
}
variable "instances" {
  type = map(string)
  description = "instance ids for attaching them to target group"
}