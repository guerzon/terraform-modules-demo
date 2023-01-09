# Input variables

variable "customer" {
  type = string
  description = "Name of the customer"
}

variable "owner" {
  type = string
  description = "Technical owner"
}

variable "environment" {
  type = string
  description = "Environment"
  validation {
    condition = contains(["Development", "Testing", "QA", "Production"], var.environment)
    error_message = "Invalid environment. Accepted values are Development, Staging, QA, and Production."
  }
}

variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC"
  validation {
    condition  =  can(cidrhost(var.vpc_cidr, 0))
    error_message = "Must be a valid IPv4 CIDR."
  }
}

variable "public_subnet_1" {
  description = "CIDR block for the first public subnet"
  type = string
  validation {
    condition  =  can(cidrhost(var.public_subnet_1, 0))
    error_message = "Must be a valid IPv4 CIDR."
  }
}

variable "public_subnet_2" {
  description = "CIDR block for the second public subnet"
  type = string
  validation {
    condition  =  can(cidrhost(var.public_subnet_2, 0))
    error_message = "Must be a valid IPv4 CIDR."
  }
}

variable "private_subnet_1" {
  description = "CIDR block for the first private subnet"
  type = string
  validation {
    condition  =  can(cidrhost(var.private_subnet_1, 0))
    error_message = "Must be a valid IPv4 CIDR."
  }
}

variable "private_subnet_2" {
  description = "CIDR block for the second private subnet"
  type = string
  validation {
    condition  =  can(cidrhost(var.private_subnet_2, 0))
    error_message = "Must be a valid IPv4 CIDR."
  }
}
