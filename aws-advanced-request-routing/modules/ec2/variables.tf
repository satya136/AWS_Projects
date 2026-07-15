variable "region" {
  default = "us-east-1"
}
variable "instance_type" {
  type = map
  default = {
    dev = "t3.micro",
    prod = "m5.large"
  }
}
variable "env" {
    default = "dev"
}
variable "http_port" {
    default = 80  
}
variable "cidr" {
  default = "0.0.0.0/0"
}
variable "names" {
  type = set(string)
  default = ["blue","red"]
}

variable "bucket_name" {
}
variable "bucket_arn" {
  
}