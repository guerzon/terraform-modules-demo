
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

variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "private_subnets_cidr" {
  description = "CIDR blocks for the private subnets"
  type = list
}
