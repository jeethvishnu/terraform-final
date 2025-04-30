#AWS Systems Manager (SSM) Parameter Store is a service that provides secure, hierarchical storage for 
# configuration data and secrets management. It is used to store sensitive information like passwords, 
# database connection strings, and API keys as parameters. 
# These parameters can be stored as plain text or encrypted data, ensuring security and scalability.
resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project}/${var.env}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
}

#this is for pushing ......up one is different this is differrnt
#this is for pub subnet
#if we are writing here means previously we need to declare them in our module outputs. then only it wull catch
resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project}/${var.env}/pubic_subnet_ids"
  type  = "StringList"
  value = join("," ,module.vpc.public_subnet_ids) #converting lst to strlst using join func
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project}/${var.env}/private_subnet_ids"
  type  = "StringList"
  value = join("," ,module.vpc.private_subnet_ids)
}

resource "aws_ssm_parameter" "db_subnet_group_name" {
  name  = "/${var.project}/${var.env}/db_subnet_group_name"
  type  = "StringList"
  value = module.vpc.database_subnet_group_name
}

