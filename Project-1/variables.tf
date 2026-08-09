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

variable "db_port" {
}

variable "db_instance" {
}

variable "db_storage" {
}

variable "db_storage_type" {
}

variable "db_engine" {
}

variable "db_engine_version" {
}

variable "db_instance_identifier" {
}

variable "db_name" {
}

variable "username" {
    sensitive = true
    default = "admin"
}