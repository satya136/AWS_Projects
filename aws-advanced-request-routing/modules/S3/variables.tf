variable "region" {
  default = "us-east-1"
}
variable "names" {
  type = set(string)
  default = ["blue","red"]
}