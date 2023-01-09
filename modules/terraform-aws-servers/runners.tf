
## Runners

resource "aws_instance" "runner1" {
  ami                         =  var.centos7_ami
  subnet_id                   =  var.server_subnets[0]
  instance_type               =  var.runner_instancesize
  associate_public_ip_address =  false

  key_name   = var.key_name
  monitoring = true
  vpc_security_group_ids = [
    var.security_group_ids.management_sg,
    var.security_group_ids.runners_sg
  ]

  root_block_device {
    delete_on_termination     =  var.runner_storage.delete_on_termination
    volume_size               =  var.runner_storage.size
    tags   =  merge(local.common_tags, {
      Name = lower("${var.customer}-${var.environment}-runner1-rootvol")
    })
  }
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-runner1")
  })
}

resource "aws_instance" "runner2" {
  ami                         =  var.centos7_ami
  subnet_id                   =  var.server_subnets[1]
  instance_type               =  var.runner_instancesize
  associate_public_ip_address =  false

  key_name   = var.key_name
  monitoring = true

  vpc_security_group_ids = [
    var.security_group_ids.management_sg,
    var.security_group_ids.runners_sg
  ]
  root_block_device {
    delete_on_termination     =  var.runner_storage.delete_on_termination
    volume_size               =  var.runner_storage.size
    tags   =  merge(local.common_tags, {
      Name = lower("${var.customer}-${var.environment}-runner2-rootvol")
    })
  }
  tags = merge(local.common_tags, {
    Name = lower("${var.customer}-${var.environment}-runner2")
  })
}
