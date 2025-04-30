resource "aws_instance" "db" {
    ami = "ami-09c813fb71547fc4f"
    vpc_security_group_ids = [aws_security_group.allow-all.id] #if we dont give specific sec_grp then default group will be created
    instance_type = "t2.micro"


    tags = {
        name = "db"

    }
}



resource "aws_security_group" "allow-all" {
    name = "allow-all"
    description = "allowing ssh"


  dynamic "ingress" {                   #ingress means inbound, we use dynamic because if theres any repeatative block we use this key
    for_each = var.inbound
    content = {   #we use because tf will understand to repeat this block
        from_port        = ingress.value["port"]
        to_port          = 22
        protocol         = ingress.value["protocol]
        cidr_blocks      = ingress.value["cidr"]
    
    }
    
  }

  egress {                          # outbound
    from_port        = 0 # 0 means all ports
    to_port          = 0
    protocol         = "-1" # -1 means from all protocol
    cidr_blocks      = ["0.0.0.0/0"]
    
  }


    tags = {
        name = "allow-ssh"
        CreatedBy = "vishnu"
    }
}


