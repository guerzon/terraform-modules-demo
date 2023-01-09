
## Internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = lower("${var.customer}-${var.environment}-igw")
    Owner = var.owner
    Environment = var.environment
  }
}

## EIPs

resource "aws_eip" "eip1" {}

resource "aws_eip" "eip2" {}

## NAT Gateways

resource "aws_nat_gateway" "ngw1" {
  subnet_id = aws_subnet.public_subnet_1.id
  connectivity_type = "public"
  allocation_id = aws_eip.eip1.id
  depends_on = [
    aws_internet_gateway.igw
  ]
  tags = {
    Name = lower("${var.customer}-${var.environment}-ngw1")
    Owner = var.owner
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "ngw2" {
  subnet_id = aws_subnet.public_subnet_2.id
  allocation_id = aws_eip.eip2.id
  depends_on = [
    aws_internet_gateway.igw
  ]
  tags = {
    Name = lower("${var.customer}-${var.environment}-ngw2")
    Owner = var.owner
    Environment = var.environment
  }
}
