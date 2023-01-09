
module "vpc" {
  source      =  "../../modules/terraform-aws-network"
  customer    =  "customer1"
  environment =  "Development"
  owner       =  "Jane Doe"
  vpc_cidr    =  "172.61.0.0/16"
  public_subnet_1 = "172.61.0.0/18"
  public_subnet_2 = "172.61.64.0/18"
  private_subnet_1 = "172.61.128.0/18"
  private_subnet_2 = "172.61.192.0/18"
}

module "security" {
  source = "../../modules/terraform-aws-security"
  customer    =  "customer1"
  environment =  "Development"
  owner       =  "Jane Doe"

  vpc_id  =  module.vpc.vpc_id
  private_subnets_cidr = [
    module.vpc.private_subnet_cidr1,
    module.vpc.private_subnet_cidr2
  ]

  depends_on = [
    module.vpc
  ]
}

module "db" {
  source      =  "../../modules/terraform-aws-storage"
  customer    =  "customer1"
  environment =  "Development"
  owner       =  "Jane Doe"
  db_name     =  "myappdbdev"
  db_storage  = {
    initial = 100
    maximum = 250
  }
  db_type             =  "postgres"
  db_version          =  "13.7"
  db_instance_class   =  "db.r5.large"
  db_master_user  = {
    username  =  "postgresadm"
    password  =  "$ecurePassw0rd"
  }
  db_apply_immediately       = true
  db_backup_retention_period = 21
  db_subnets = [
    module.vpc.private_subnet_id1,
    module.vpc.private_subnet_id2
  ]
  security_group_ids = {
    management_sg = module.security.management_sg_id
    database_sg = module.security.database_sg_id
  }
  depends_on = [
    module.vpc
  ]
}

module "servers" {
  source = "../../modules/terraform-aws-servers"
  customer    =  "customer1"
  environment =  "Development"
  owner       =  "Jane Doe"
  key_name    =  "terraform-test"

  server_subnets = [
    module.vpc.private_subnet_id1,
    module.vpc.private_subnet_id2
  ]
  appsrv_instancesize = "c5.xlarge"
  appsrv_storage = {
    size = 100
    delete_on_termination = true
  }
  runner_instancesize = "c5.large"

  iam_instanceprofile = module.db.files_instanceprofile
  security_group_ids = {
    management_sg = module.security.management_sg_id
    appservers_sg = module.security.appservers_sg_id
    runners_sg = module.security.runners_sg_id
  }

  depends_on = [
    module.vpc,
    module.db,
    module.security
  ]
}
