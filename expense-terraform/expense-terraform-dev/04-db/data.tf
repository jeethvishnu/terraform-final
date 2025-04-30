data "aws_ssm_parameter" "db_sg_id" {
  name = "/${var.project}/${var.env}/db_sg_id"
}

data "aws_ssm_parameter" "db_subnet_group_name" {
  name = "/${var.project}/${var.env}/db_subnet_group_name"
}
