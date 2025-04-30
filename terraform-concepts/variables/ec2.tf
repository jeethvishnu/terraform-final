resource "aws_instance" "db" {
    ami = var.image_id
    vpc_security_group_ids = [aws_security_group.allow-all.id]
    instance_type = var.instance_type


    tags = var.tags
}


resource "aws_security_group" "allow-all" {
    name = var.sg
    description = var.desc

    #this is block
  ingress {                   #means inbound
    from_port        = var.fp
    to_port          = var.tp
    protocol         = var.type_call
    cidr_blocks      = var.allow_cidr
    
  }

      egress {                          # outbound
    from_port        = 0 # 0 means all ports
    to_port          = 0
    protocol         = "-1" # -1 means from all protocol
    cidr_blocks      = ["0.0.0.0/0"]
    
  }


    tags = {
        Name = "allow-ssh"
        CreatedBy = "vishnu"
    }
}

