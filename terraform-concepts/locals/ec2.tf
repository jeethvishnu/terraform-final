resource "aws_instance" "db" {
    ami = local.ami
    vpc_security_group_ids = [local.sg] 
    instance_type = local.type


    tags = local.tags
}


