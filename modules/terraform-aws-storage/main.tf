
locals {
  is_production = tobool(length(regexall("prod", lower(var.environment))) > 0)
  common_tags = {
    Owner       = var.owner,
    Customer    = var.customer
    Environment = var.environment
  }
}

resource "aws_db_subnet_group" "database_subnet_group" {
  name        =  lower("${var.customer}-${var.environment}-dbsubnetgrp")
  subnet_ids  =  [var.db_subnets[0], var.db_subnets[1]]
  description =  "Database subnets (private)"
  tags = {
    Name        = lower("${var.customer}-${var.environment}-dbsubnetgrp")
    Owner       = var.owner
    Environment = var.environment
  }
}

resource "aws_db_instance" "database" {
  identifier                 =  lower("${var.customer}-${var.environment}-db")
  engine                     =  var.db_type
  engine_version             =  var.db_version
  auto_minor_version_upgrade =  false
  allocated_storage          =  var.db_storage.initial
  max_allocated_storage      =  var.db_storage.maximum
  storage_type               =  "io1"
  iops                       =  5000
  instance_class             =  var.db_instance_class
  username                   =  var.db_master_user.username
  password                   =  var.db_master_user.password
  deletion_protection        =  local.is_production
  apply_immediately          =  var.db_apply_immediately

  backup_retention_period    =  var.db_backup_retention_period
  skip_final_snapshot        =  local.is_production ? false : true
  copy_tags_to_snapshot      =  true

  # For this demo: The database port should always be 6363
  port    =  6363
  db_name =  var.db_name

  # For this demo: Performance insights and logs are required
  performance_insights_enabled          = true
  performance_insights_retention_period = 186
  enabled_cloudwatch_logs_exports       = ["postgresql", "upgrade"]

  # For this demo: we specify multi-az db deployment if the environment is for production
  multi_az             = local.is_production
  db_subnet_group_name = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [
    var.security_group_ids.management_sg,
    var.security_group_ids.database_sg
  ]

  tags = {
    Name        = lower("${var.customer}-${var.environment}-database")
    Owner       = var.owner
    Environment = var.environment
  }
  depends_on = [aws_db_subnet_group.database_subnet_group]
}
