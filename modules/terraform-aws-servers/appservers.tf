
## Application servers

resource "aws_instance" "appsrv1" {
  ami                         =  var.centos7_ami
  subnet_id                   =  var.server_subnets[0]
  instance_type               =  var.appsrv_instancesize
  associate_public_ip_address =  false

  key_name   = var.key_name
  monitoring = true
  vpc_security_group_ids = [
    var.security_group_ids.management_sg,
    var.security_group_ids.appservers_sg
  ]
  iam_instance_profile = var.iam_instanceprofile
  root_block_device {
    delete_on_termination     =  var.appsrv_storage.delete_on_termination
    volume_size               =  var.appsrv_storage.size
    tags   =  merge(local.common_tags, {
      Name = lower("${var.customer}-${var.environment}-appsrv1-rootvol")
    })
  }
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-appsrv1")
  })
}

resource "aws_instance" "appsrv2" {
  ami                         =  var.centos7_ami
  subnet_id                   =  var.server_subnets[1]
  instance_type               =  var.appsrv_instancesize
  associate_public_ip_address =  false

  key_name   = var.key_name
  monitoring = true

  vpc_security_group_ids = [
    var.security_group_ids.management_sg,
    var.security_group_ids.appservers_sg
  ]
  iam_instance_profile = var.iam_instanceprofile
  root_block_device {
    delete_on_termination     =  var.appsrv_storage.delete_on_termination
    volume_size               =  var.appsrv_storage.size
    tags   =  merge(local.common_tags, {
      Name = lower("${var.customer}-${var.environment}-appsrv2-rootvol")
    })
  }
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-appsrv2")
  })
}
