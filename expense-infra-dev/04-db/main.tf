module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.project}-${var.env}"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "transactions" #default schema for expense project
  username = "root"
  port     = "3306"

#   iam_database_authentication_enabled = true

  vpc_security_group_ids = [data.aws_ssm_parameter.db_sg_id.value]

#   maintenance_window = "Mon:00:00-Mon:03:00"
#   backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
#   monitoring_interval    = "30"
#   monitoring_role_name   = "MyRDSMonitoringRole"
#   create_monitoring_role = true


  # DB subnet group
#   create_db_subnet_group = true
  # subnet_ids             = ["subnet-12345678", "subnet-87654321"]

db_subnet_group_name = data.aws_ssm_parameter.db_subnet_group_name.value

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  # deletion_protection = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project}-${var.env}"
    }
  )
# this is for managing password by manually then only the password parameter works

  manage_master_user_password = false
  password = "ExpenseApp1"
  #refer notes
  skip_final_snapshot = true

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}

#create r53 records for rds endpoint

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"

  zone_name = var.zone_name

  records = [
    {
      name    = "db-${var.env}"
      type    = "CNAME"
      ttl = 1
      records = [
        module.db.db_instance_address
      ]
      
    }
  ]
}

