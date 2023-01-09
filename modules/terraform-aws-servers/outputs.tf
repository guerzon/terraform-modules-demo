
output "appsrv1_ip" {
  value = aws_instance.appsrv1.private_ip
  description = "Private IPv4 address for appsrv1"
}

output "appsrv2_ip" {
  value = aws_instance.appsrv2.private_ip
  description = "Private IPv4 address for appsrv2"
}

output "runner1_ip" {
  value = aws_instance.runner1.private_ip
  description = "Private IPv4 address for runner1"
}

output "runner2_ip" {
  value = aws_instance.runner2.private_ip
  description = "Private IPv4 address for runner2"
}
