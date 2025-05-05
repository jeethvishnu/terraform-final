data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.env}/vpc_id"
}

data "aws_ssm_parameter" "bastion_id" {
  name = "/${var.project}/${var.env}"/bastion_sg_id
  
}