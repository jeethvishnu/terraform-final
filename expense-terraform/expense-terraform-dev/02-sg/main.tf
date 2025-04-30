#security group for db

module "db" {
    source = "../aws-sec-grp"
    project = var.project
    env = var.env
    sg_decsript = var.db_sg_descr
    vpc_id = data.aws_ssm_parameter.vpc_id.value #whatever the vpc val we gave in parameter that will store here
    common_tags = var.common_tags
    sg_name = "db"
  
}

#security grp for backend
module "backend" {
    source = "../aws-sec-grp"
    project = var.project
    env = var.env
    sg_decsript = "sg for backend"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
    sg_name = "backend"
  
}

#security grp for frontend
module "frontend" {
    source = "../aws-sec-grp"
    project = var.project
    env = var.env
    sg_decsript = "sg for frontend"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
    sg_name = "frontend"
  
}

#bastion
module "bastion" {
    source = "../aws-sec-grp"
    project = var.project
    env = var.env
    sg_decsript = "sg for bastion"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
    sg_name = "bastion"
  
}

#ansible
module "ansible" {
    source = "../aws-sec-grp"
    project = var.project
    env = var.env
    sg_decsript = "sg for anisble"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
    sg_name = "ansible"
  
}

#rules for sg inbound rules
#db is accepting connections from backend
#security grp rule
resource "aws_security_group_rule" "db_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id =module.backend.sg_id #its dynamic source is from where you are getting  traffic
  security_group_id = module.db.sg_id #we are writing here bcs we are adding rule for db
}

#db accepting from bastion
resource "aws_security_group_rule" "db_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id =module.bastion.sg_id #its dynamic source is from where you are getting  traffic
  security_group_id = module.db.sg_id #we are writing here bcs we are adding rule for db
}


#backend accepting connections from frontend
resource "aws_security_group_rule" "backend_frontend" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id =module.frontend.sg_id #its dynamic source is from where you are getting  traffic
  security_group_id = module.backend.sg_id 
}

#backend accepting from bastion
resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id =module.bastion.sg_id #its dynamic source is from where you are getting  traffic
  security_group_id = module.backend.sg_id 
}

#backend accepting from ansible
resource "aws_security_group_rule" "backend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id =module.ansible.sg_id #its dynamic source is from where you are getting  traffic
  security_group_id = module.backend.sg_id 
}

#frontend accepting from internet
resource "aws_security_group_rule" "frontend_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"] #since we dont have source coming so we keep cidrs
  security_group_id = module.frontend.sg_id 
}

#frontend to bastion
resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22  
  protocol          = "tcp"
  source_security_group_id =module.bastion.sg_id #its dynamic source is from where you are getting  traffic
  security_group_id = module.frontend.sg_id 
}

#frontend to ansible
resource "aws_security_group_rule" "frontend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id =module.ansible.sg_id #its dynamic source is from where you are getting  traffic
  security_group_id = module.frontend.sg_id 
}

#bastion to public
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"] #since we dont have source coming so we keep cidrs
  security_group_id = module.bastion.sg_id 
}

resource "aws_security_group_rule" "ansible_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"] #since we dont have source coming so we keep cidrs
  security_group_id = module.ansible.sg_id 
}