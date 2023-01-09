
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = lower("${var.customer}-${var.environment}-vpc")
    Owner = var.owner
    Environment = var.environment
  }
}
