
## Route tables

resource "aws_route_table" "public_rt1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = lower("${var.customer}-${var.environment}-public-rt1")
    Owner = var.owner
    Environment = var.environment
  }
}

resource "aws_route_table" "public_rt2" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = lower("${var.customer}-${var.environment}-public-rt2")
    Owner = var.owner
    Environment = var.environment
  }
}

resource "aws_route_table" "private_rt1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw1.id
  }
  # This is how you would add a route to a private network via a Transit Gateway
  # route {
  #   cidr_block = "10.0.0.0/24"
  #   gateway_id = transit_gateway_id.tgw.id
  # }
  # route {
  #   cidr_block = "192.168.10.0/18"
  #   gateway_id = transit_gateway_id.tgw.id
  # }
  tags = {
    Name = lower("${var.customer}-${var.environment}-private-rt1")
    Owner = var.owner
    Environment = var.environment
  }
}

resource "aws_route_table" "private_rt2" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw2.id
  }
  tags = {
    Name = lower("${var.customer}-${var.environment}-private-rt2")
    Owner = var.owner
    Environment = var.environment
  }
}

# Route table associations
resource "aws_route_table_association" "public_rt1_assoc" {
  route_table_id = aws_route_table.public_rt1.id
  subnet_id = aws_subnet.public_subnet_1.id
}
resource "aws_route_table_association" "public_rt2_assoc" {
  route_table_id = aws_route_table.public_rt2.id
  subnet_id = aws_subnet.public_subnet_2.id
}
resource "aws_route_table_association" "private_rt1_assoc" {
  route_table_id = aws_route_table.private_rt1.id
  subnet_id = aws_subnet.private_subnet_1.id
}
resource "aws_route_table_association" "private_rt2_assoc" {
  route_table_id = aws_route_table.private_rt2.id
  subnet_id = aws_subnet.private_subnet_2.id
}

# Main route table for the VPC
resource "aws_main_route_table_association" "vpc_main_rt" {
  vpc_id = aws_vpc.vpc.id
  route_table_id = aws_route_table.private_rt1.id
}
