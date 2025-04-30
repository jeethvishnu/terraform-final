locals {
    ami = "ami-09c813fb71547fc4f"
    sg = "sg-07fad016c7fd8f34f"
    #type = "t2.micro"
    type = var.instance_name == "db" ? "t3.small" : "t3.micro"
    tags = {
        Name = "db"

    }

}