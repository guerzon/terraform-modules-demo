
output "management_sg_id" {
  value = aws_security_group.management_sg.id
  description = "Security group ID for the Management security group"
}

output "appservers_sg_id" {
  value = aws_security_group.appservers_sg.id
  description = "Security group ID for the app servers' security group"
}

output "loadbalancers_sg_ig" {
  value = aws_security_group.loadbalancers_sg.id
  description = "Security group ID for the load balancers' security group"
}

output "runners_sg_id" {
  value = aws_security_group.runners_sg.id
  description = "Security group ID for the runners' security group"
}

output "database_sg_id" {
  value = aws_security_group.database_sg.id
  description = "Security group ID for the database security group"
}
