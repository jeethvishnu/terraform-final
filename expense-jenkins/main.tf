module "jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins"

  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0d91541a2fc6f3893"]
  subnet_id     = "subnet-0c31f5cfaef3e61d2"
  ami = data.aws_ami.ami_info.id
  user_data = file("jenkins.sh")

  tags = {
    Name = "jenkins"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "jenkins-agent" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins-agent"

  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0d91541a2fc6f3893"]
  subnet_id     = "subnet-0c31f5cfaef3e61d2"
  ami = data.aws_ami.ami_info.id
  user_data = file("jenkins-agent.sh")

  tags = {
    Name = "jenkins-agent"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_key_pair" "tools" {
  key_name   = "tools"
  public_key = file("~/.ssh/tools.pub")
  
}

module "nexus" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "nexus"

  instance_type = "t3.medium"
  vpc_security_group_ids = ["sg-0d91541a2fc6f3893"]
  subnet_id     = "subnet-0c31f5cfaef3e61d2"
  ami = data.aws_ami.nexus_ami.id
  key_name = aws_key_pair.tools.key_name
  root_block_device = {
    
      volume_type = "gp3"
      volume_size = 30
      }
  

  tags = {
    Name = "nexus"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"

  zone_name = var.zone_name

  records = [
    {
      name    = "jenkins"
      type    = "A"
      ttl = 1
      records = [
        module.jenkins.public_ip
      ]
     
    },
    {
      name    = "jenkins-agent"
      type    = "A"
      ttl     = 1
      records = [
        module.jenkins-agent.private_ip
      ]
    },
    {
      name    = "nexus"
      type    = "A"
      ttl     = 1
      records = [
        module.nexus.private_ip
      ]
    }
  ]

}