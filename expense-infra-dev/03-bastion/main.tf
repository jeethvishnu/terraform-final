module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project}-${var.env}-bastion"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.allow_all.value]
  #convert string lst to lst and get first element
  subnet_id              = local.public_subnet_id
  ami    = data.aws_ami.ami_info.id
  user_data = file("bastion.sh")

  tags = merge(
    var.common_tags,
    {
      Name: "${var.project}-${var.env}-bastion"
    }
  )
}

