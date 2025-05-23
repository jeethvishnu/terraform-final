resource "aws_key_pair" "vpn" {
    key_name = "openvpn"
    #can paste the pub key directly
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINpNO5tMS+eklH/ZbnczeCkKzkBBK1eWEZk+gr6XyEus jeeth@vishnu"
  
}

module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  key_name = aws_key_pair.vpn.key_name
  name = "${var.project}-${var.env}-vpn"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  #convert string lst to lst and get first element
  subnet_id              = local.public_subnet_id
  ami    = data.aws_ami.ami_info.id
  

  tags = merge(
    var.common_tags,
    {
      Name: "${var.project}-${var.env}-vpn"
    }
  )
}

