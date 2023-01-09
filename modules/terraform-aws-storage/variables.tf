
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

# In this demo, this application only supports MySQL and PostgreSQL backends.
variable "db_type" {
  description = "Database type"
  type = string
  validation {
    condition = contains(["mysql", "postgres"], var.db_type)
    error_message = "Invalid database type. We currently only support 'mysql' and 'postgres' databases."
  }
}

variable "db_version" {
  description = "Database engine version"
  type = string
}

# In this demo, we require to start small and let autoscaling increase according to actual DB usage.
variable "db_storage" {
  description = "Specify storage settings for this database."
  type = object({
    initial = number
    maximum = number
  })
  validation {
    condition = (var.db_storage.initial >= 100)
    error_message = "Initial storage size must be at least 100 GiB."
  }
  validation {
    condition = (var.db_storage.initial <= var.db_storage.maximum)
    error_message = "Initial storage size should be less than maximum storage."
  }
}

variable "db_instance_class" {
  description  =  "Database instance class"
  default      =  "db.r5.xlarge"
  type         =  string
  validation {
    condition  = can(regex("^(db.r5)", var.db_instance_class))
    error_message = "Invalid instance class. Please only specify a db.r5 instance class, or use the default db.r5.xlarge."
  }
}

variable "db_apply_immediately" {
  description = "Apply changes immediately"
  type = bool
  default = false
}

# In this demo, we were required to comply with a company-wide password policy
# to use passwords with at least 10 characters.
variable "db_master_user" {
  description  =  "Master database user."
  type  =  object({
    username  =  string
    password  =  string
  })
  validation {
    condition  =  (length(var.db_master_user.password) > 10)
    error_message = "Master password should be at least 10 characters."
  }
  sensitive  =  true
}

# In this demo, there is a business requirement to not keep backups longer than a month (due to cost)
# and a technical requirement to keep backups for at least 14 days.
variable "db_backup_retention_period" {
  type = number
  description = "Backup retention period (days)"
  default = 14
  validation {
    condition = (var.db_backup_retention_period >= 14 && var.db_backup_retention_period <= 31)
    error_message = "Allowed backup retention is between 14 and 31 days."
  }
}

# In this demo, we set a default database name as required by the application, but consumers can override this.
variable "db_name" {
  description = "Database name"
  default = "appdb"
  type = string
}

variable "db_subnets" {
  description = "Database subnets."
  type = list
}

variable "security_group_ids" {
  description = "Security group IDs"
  type = object({
    management_sg = string
    database_sg = string
  })
}
