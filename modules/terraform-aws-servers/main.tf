
locals {
  common_tags = {
    Owner       = var.owner,
    Customer    = var.customer
    Environment = var.environment
  }
}
