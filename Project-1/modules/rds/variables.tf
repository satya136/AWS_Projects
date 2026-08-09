variable "vpc_id" {
}

variable "vpc_cidr" {
}

variable "private_subnet_ids" {
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
}
