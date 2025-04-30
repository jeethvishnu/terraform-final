resource "aws_instance" "db" {
    ami = "ami-09c813fb71547fc4f"
    vpc_security_group_ids = ["sg-07fad016c7fd8f34f"]
    instance_type = "t2.micro"


    tags = {
        name = "db"

    }
}
