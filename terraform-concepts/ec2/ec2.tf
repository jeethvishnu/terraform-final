
resource "aws_security_group" "allow-all" {
    name = "allow-all"
    description = "allowing ssh"


  ingress {                   #means inbound
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
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

resource "aws_instance" "db" {
    ami = "ami-09c813fb71547fc4f"
    vpc_security_group_ids = [aws_security_group.allow-all.id] #if we dont give specific sec_grp then default group will be created
    instance_type = "t2.micro"


    tags = {
        name = "db"

    }
}

