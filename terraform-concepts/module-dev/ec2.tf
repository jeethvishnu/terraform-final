resource "aws_instance" "db" {
    ami = var.ami
    vpc_security_group_ids = var.sgrp #if we dont give specific sec_grp then default group will be created
    instance_type = var.type


    tags = var.tags
}

