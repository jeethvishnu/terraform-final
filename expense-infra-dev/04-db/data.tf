data "aws_ssm_parameter" "allow_all_sg_id" {
  name = "/${var.project}/${var.env}/allow_all_sg_id"
}

data "aws_ssm_parameter" "db_subnet_group_name" {
  name = "/${var.project}/${var.env}/db_subnet_group_name"
}
