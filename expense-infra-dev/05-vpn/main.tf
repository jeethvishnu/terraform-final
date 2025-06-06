module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  key_name = "vpn-pb"
  name = "${var.project}-${var.env}-vpn"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  #convert string lst to lst and get first element
  subnet_id              = local.public_subnet_id
  ami    = data.aws_ami.ami_info.id
  associate_public_ip_address = true
  
  

  tags = merge(
    var.common_tags,
    {
      Name: "${var.project}-${var.env}-vpn"
    }
  )
}

