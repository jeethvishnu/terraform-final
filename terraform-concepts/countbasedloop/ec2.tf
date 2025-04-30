resource "aws_instance" "db" {
    #count = 3
    count = length(var.instance_names) # length is a func used to count the values in that variable
    ami = "ami-09c813fb71547fc4f"
    vpc_security_group_ids = [aws_security_group.allow-all.id]
    instance_type = "t2.micro"
    tags = {
        Name = var.instance_names[count.index]
    }

}

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
