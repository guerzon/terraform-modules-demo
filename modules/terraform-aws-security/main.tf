
locals {
  common_tags = {
    Owner       = var.owner,
    Customer    = var.customer
    Environment = var.environment
  }
}

## For this demo, we are allowing hypothetical CIDRs

# Security Group for management purposes
resource "aws_security_group" "management_sg" {
  name            =  lower("${var.customer}-${var.environment}-management-sg")
  description     =  "Security Group for management"
  vpc_id          =  var.vpc_id
  ingress {
    description   =  "SSH from company gateways, the private subnets, and the internal subnet"
    from_port     =  22
    to_port       =  22
    protocol      =  "tcp"
    cidr_blocks   =  [
      "1.1.1.1/32",
      "2.2.2.2/32",
      var.private_subnets_cidr[0],
      var.private_subnets_cidr[1],
      "10.10.0.0/16"
    ]
  }
  ingress {
    description   =  "HTTP from company gateways"
    from_port     =  80
    to_port       =  80
    protocol      =  "tcp"
    cidr_blocks   =  ["1.1.1.1/32", "2.2.2.2/32"]
  }
  ingress {
    description   =  "HTTPS from company gateways"
    from_port     =  443
    to_port       =  443
    protocol      =  "tcp"
    cidr_blocks   =  ["1.1.1.1/32", "2.2.2.2/32"]
  }
  ingress {
    description   =  "ICMP from internal subnet"
    from_port     =  -1
    to_port       =  -1
    protocol      =  "icmp"
    cidr_blocks   =  ["10.10.0.0/16"]
  }
  ingress {
    description   =  "ICMP from the private subnets"
    from_port     =  -1
    to_port       =  -1
    protocol      =  "icmp"
    cidr_blocks   =  [
      var.private_subnets_cidr[0],
      var.private_subnets_cidr[1]
    ]
  }
  egress {
    description   =  "Allow all outbound"
    from_port     =  0
    to_port       =  0
    protocol      =  "-1"
    cidr_blocks   =  ["0.0.0.0/0"]
  }
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-management-sg")
  })
}

## Security Group for the LBs
resource "aws_security_group" "loadbalancers_sg" {
  name               =  lower("${var.customer}-${var.environment}-loadbalancers-sg")
  description        =  "Security Group for load-balancers"
  vpc_id             =  var.vpc_id
  ingress {
    description      =  "Allow HTTP from everywhere"
    from_port        =  80
    to_port          =  80
    protocol         =  "tcp"
    cidr_blocks      =  ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }
  ingress {
    description      =  "Allow HTTPS from everywhere"
    from_port        =  443
    to_port          =  443
    protocol         =  "tcp"
    cidr_blocks      =  ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }
  egress {
    description      =  "Allow all outbound"
    from_port        =  0
    to_port          =  0
    protocol         =  "-1"
    cidr_blocks      =  ["0.0.0.0/0"]
  }
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-loadbalancers-sg")
  })
}

## Security Group for the application servers
resource "aws_security_group" "appservers_sg" {
  name            =  lower("${var.customer}-${var.environment}-appservers-sg")
  description     =  "Security Group for appservers"
  vpc_id          =  var.vpc_id
  ingress {
    description   =  "Allow all from the private subnets"
    from_port     =  1
    to_port       =  65535
    protocol      =  "tcp"
    cidr_blocks   =  [
      var.private_subnets_cidr[0],
      var.private_subnets_cidr[1]
    ]
  }
  ingress {
    description      =  "Allow HTTP from the LB"
    from_port        =  8080
    to_port          =  8080
    protocol         =  "tcp"
    security_groups  =  [aws_security_group.loadbalancers_sg.id]
  }
  ingress {
    description      =  "Allow HTTPs from the LB"
    from_port        =  8443
    to_port          =  8443
    protocol         =  "tcp"
    security_groups  =  [aws_security_group.loadbalancers_sg.id]
  }
  egress {
    description    =  "Allow all outbound"
    from_port      =  0
    to_port        =  0
    protocol       =  "-1"
    cidr_blocks    =  ["0.0.0.0/0"]
  }
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-appservers-sg")
  })
}

## Security Group for the runners
resource "aws_security_group" "runners_sg" {
  name            =  lower("${var.customer}-${var.environment}-runners-sg")
  description     =  "Security Group for runners"
  vpc_id          =  var.vpc_id
  ingress {
    description   =  "Allow all from the private subnets"
    from_port     =  1
    to_port       =  65535
    protocol      =  "tcp"
    cidr_blocks   =  [
      var.private_subnets_cidr[0],
      var.private_subnets_cidr[1]
    ]
  }
  egress {
    description  =  "Allow all outbound"
    from_port    =  0
    to_port      =  0
    protocol     =  "-1"
    cidr_blocks  =  ["0.0.0.0/0"]
  }
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-runners-sg")
  })
}

## Security Group for the database
resource "aws_security_group" "database_sg" {
  name          =  lower("${var.customer}-${var.environment}-database-sg")
  description   =  "Security Group for the database"
  vpc_id        =  var.vpc_id
  ingress {
    description      =  "Allow database connectivity from the appservers"
    from_port        =  6363
    to_port          =  6363
    protocol         =  "tcp"
    security_groups  =  [aws_security_group.appservers_sg.id]
  }
  egress {
    description    =  "Allow all outbound"
    from_port      =  0
    to_port        =  0
    protocol       =  "-1"
    cidr_blocks    =  ["0.0.0.0/0"]
  }
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-database-sg")
  })
}
