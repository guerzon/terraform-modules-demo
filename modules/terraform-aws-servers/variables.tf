
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

variable "centos7_ami" {
  description = "CentOS 7 AMI ID"
  type = string
  default = "ami-0c1f3a8058fde8814"
}

variable "server_subnets" {
  description = "Database subnets."
  type = list
}

variable "appsrv_instancesize" {
  description = "Instance size of the application servers."
  type = string
}

variable "runner_instancesize" {
  description = "Instance size for the runners."
  type = string
}

variable "key_name" {
  description = "Existing SSH key name."
  type = string
}

variable "appsrv_storage" {
  description = "Storage details for the app server."
  type = object({
    size = number
    delete_on_termination = bool
  })
}

variable "runner_storage" {
  description = "Storage details for the runners."
  type = object({
    size = number
    delete_on_termination = bool
  })
  default = {
    delete_on_termination = true
    size = 50
  }
}

variable "security_group_ids" {
  description = "Security group IDs"
  type = object({
    management_sg = string
    appservers_sg = string
    runners_sg = string
  })
}

variable "iam_instanceprofile" {
  description = "Instance profile for S3 bucket access."
  type = string
}
