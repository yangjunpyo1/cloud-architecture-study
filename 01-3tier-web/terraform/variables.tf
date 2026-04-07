variable "region" {
  default = "eu-west-2"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "public_subnet_a_cidr" {
  default = "192.168.10.0/24"
}

variable "public_subnet_b_cidr" {
  default = "192.168.110.0/24"
}

variable "private_subnet_a_cidr" {
  default = "192.168.20.0/24"
}

variable "private_subnet_b_cidr" {
  default = "192.168.120.0/24"
}

variable "db_subnet_a_cidr" {
  default = "192.168.30.0/24"
}

variable "db_subnet_b_cidr" {
  default = "192.168.130.0/24"
}