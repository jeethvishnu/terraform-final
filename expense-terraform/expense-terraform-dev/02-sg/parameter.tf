#suppose if db team started ro develop db so they need sg for db so we are keeping in the ssm parameter. thats the usage of this
resource "aws_ssm_parameter" "db_sg_id" {
    name = "/${var.project}-${var.env}/db_sg_id"
    type = "String"
    value = module.db.sg_id
  
}

#same for backend and frontend
resource "aws_ssm_parameter" "backend_sg_id" {
    name = "/${var.project}-${var.env}/backend_sg_id"
    type = "String"
    value = module.backend.sg_id
  
}

resource "aws_ssm_parameter" "frontend_sg_id" {
    name = "/${var.project}-${var.env}/frontend_sg_id"
    type = "String"
    value = module.frontend.sg_id
  
}

resource "aws_ssm_parameter" "bastion_sg_id" {
    name = "/${var.project}/${var.env}/bastion_sg_id"
    type = "String"
    value = module.bastion.sg_id
  
}

resource "aws_ssm_parameter" "ansible_sg_id" {
    name = "/${var.project}-${var.env}/ansible_sg_id"
    type = "String"
    value = module.ansible.sg_id
  
}