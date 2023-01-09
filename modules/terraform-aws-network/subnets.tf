
resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_1
  availability_zone = "eu-west-1a"
  tags = {
    Name = lower("${var.customer}-${var.environment}-public-subnet-1")
    Owner = var.owner
    Environment = var.environment
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_2
  availability_zone = "eu-west-1b"
  tags = {
    Name = lower("${var.customer}-${var.environment}-public-subnet-2")
    Owner = var.owner
    Environment = var.environment
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_1
  availability_zone = "eu-west-1a"
  tags = {
    Name = lower("${var.customer}-${var.environment}-private-subnet-1")
    Owner = var.owner
    Environment = var.environment
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_2
  availability_zone = "eu-west-1b"
  tags = {
    Name = lower("${var.customer}-${var.environment}-private-subnet-2")
    Owner = var.owner
    Environment = var.environment
  }
}
