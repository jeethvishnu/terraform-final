data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project}/${var.env}/public_subnet_ids"
}

data "aws_ssm_parameter" "vpn_sg_id" {
  name = "/${var.project}-${var.env}/vpn_sg_id"
  
}
#this is taken from terraform folder datasource for ami

data "aws_ami" "ami_info" {

  most_recent      = true
  owners           = ["679593333241"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-fe8020db-*"]
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
