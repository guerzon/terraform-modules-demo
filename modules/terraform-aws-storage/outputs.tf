
output "database_endpoint" {
  value = aws_db_instance.database.endpoint
  description = "FQDN for the RDS instance"
}

output "files_instanceprofile" {
  value = aws_iam_instance_profile.files_instanceprofile.name
  description = "Instance profile name for the Files S3 bucket"
}
