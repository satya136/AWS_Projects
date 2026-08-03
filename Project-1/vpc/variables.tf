variable "vpc_cidr" {
  description = "This will contain VPC cidr"
  type        = string
}
variable "zones" {
  type        = list(string)
  description = "This will have the list of avilability zones"
  default     = ["us-east-1a", "us-east-1b"]
}
variable "public_subnets_cidr" {
  type = list(string)
}
variable "private_subnets_cidr" {
  type = list(string)
}