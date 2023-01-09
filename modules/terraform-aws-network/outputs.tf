output "vpc_id" {
  value = aws_vpc.vpc.id
  description = "ID of the VPC"
}

output "private_subnet_id1" {
  value = aws_subnet.private_subnet_1.id
  description = "Subnet ID of the first private subnet in the VPC"
}

output "private_subnet_id2" {
  value = aws_subnet.private_subnet_2.id
  description = "Subnet ID of the second private subnet in the VPC"
}

output "private_subnet_cidr1" {
  value = aws_subnet.private_subnet_1.cidr_block
  description = "CIDR range of the first private subnet in the VPC"
}

output "private_subnet_cidr2" {
  value = aws_subnet.private_subnet_2.cidr_block
  description = "CIDR range of the second private subnet in the VPC"
}
