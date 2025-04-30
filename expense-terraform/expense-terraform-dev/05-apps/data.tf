data "aws_ssm_parameter" "backend_sg_id" {
  name = "/${var.project}/${var.env}/backend_sg_id"
}

data "aws_ssm_parameter" "frontend_sg_id" {
  name = "/${var.project}/${var.env}/frontend_sg_id"
}


data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project}/${var.env}/private_subnet_ids"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project}/${var.env}/public_subnet_ids"
}

data "aws_ssm_parameter" "ansible_subnet_ids" {
  name = "/${var.project}/${var.env}/ansible_subnet_ids"
}


#this is taken from terraform folder datasource for ami

data "aws_ami" "ami_info" {

  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}