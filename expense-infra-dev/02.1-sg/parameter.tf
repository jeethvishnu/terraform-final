#suppose if db team started ro develop db so they need sg for db so we are keeping in the ssm parameter. thats the usage of this
resource "aws_ssm_parameter" "allow_all" {
    name = "/${var.project}/${var.env}/allow_all_sg_id"
    type = "String"
    value = aws_security_group.allow_all.id
  
}

